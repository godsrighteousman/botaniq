import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'watering_schedule_service.dart';

enum CareNotificationDestination { garden, clinic }

class CareNotificationService {
  CareNotificationService._();

  static final CareNotificationService instance = CareNotificationService._();

  static const _permissionAskedKey = 'care_notification_permission_asked';
  static const _waterNotificationBaseId = 4100;
  static const _clinicNotificationBaseId = 4200;

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  final ValueNotifier<CareNotificationDestination?> destination = ValueNotifier(
    null,
  );

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    tz_data.initializeTimeZones();
    try {
      final timezoneName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneName));
    } catch (error) {
      debugPrint('Cihaz saat dilimi okunamadı, UTC kullanılıyor: $error');
      tz.setLocalLocation(tz.UTC);
    }

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
      macOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );

    await _notifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: _handleNotificationResponse,
    );

    final launchDetails = await _notifications
        .getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      _setDestination(launchDetails?.notificationResponse?.payload);
    }

    _isInitialized = true;
  }

  CareNotificationDestination? consumeDestination() {
    final value = destination.value;
    destination.value = null;
    return value;
  }

  Future<void> requestPermissionAndRefresh() async {
    await initialize();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_permissionAskedKey, true);

    if (kIsWeb) {
      final webPlugin = _notifications
          .resolvePlatformSpecificImplementation<
            WebFlutterLocalNotificationsPlugin
          >();
      await webPlugin?.requestNotificationsPermission();
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      await _notifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _notifications
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      await _notifications
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }

    await refreshSchedules();
  }

  Future<void> requestPermissionOnceAndRefresh() async {
    final prefs = await SharedPreferences.getInstance();
    final hasAsked = prefs.getBool(_permissionAskedKey) ?? false;
    if (hasAsked) {
      await refreshSchedules();
      return;
    }
    await requestPermissionAndRefresh();
  }

  Future<void> markPermissionPromptSkipped() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_permissionAskedKey, true);
  }

  Future<void> refreshSchedules() async {
    try {
      await initialize();
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        await cancelCareNotifications();
        return;
      }

      final results = await Future.wait<Object?>([
        _loadPlants(user.id),
        _hasActiveSickPlant(user.id),
        _wateringRemindersEnabled(user.id),
        _languageCode(),
      ]);
      final plants = results[0] as List<Map<String, dynamic>>;
      final hasSickPlant = results[1] as bool;
      final wateringEnabled = results[2] as bool;
      final languageCode = results[3] as String;

      await cancelCareNotifications();

      if (wateringEnabled) {
        await _scheduleWateringNotifications(plants, languageCode);
      }
      if (hasSickPlant) {
        await _scheduleClinicNotifications(languageCode);
      }
    } catch (error) {
      debugPrint('Bakım bildirimleri zamanlanamadı: $error');
    }
  }

  Future<void> cancelCareNotifications() async {
    for (var slot = 0; slot < 3; slot++) {
      await _notifications.cancel(id: _waterNotificationBaseId + slot);
    }
    for (var slot = 0; slot < 2; slot++) {
      await _notifications.cancel(id: _clinicNotificationBaseId + slot);
    }
  }

  Future<List<Map<String, dynamic>>> _loadPlants(String userId) async {
    final response = await Supabase.instance.client
        .from('plants')
        .select('id, last_watered_at, watering_interval_days')
        .eq('user_id', userId);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<bool> _hasActiveSickPlant(String userId) async {
    final response = await Supabase.instance.client
        .from('sick_plants')
        .select('id')
        .eq('user_id', userId)
        .eq('status', 'active')
        .limit(1);
    return response.isNotEmpty;
  }

  Future<bool> _wateringRemindersEnabled(String userId) async {
    for (final table in const ['users', 'profiles']) {
      try {
        final response = await Supabase.instance.client
            .from(table)
            .select('watering_reminders')
            .eq('id', userId)
            .maybeSingle();
        final value = response?['watering_reminders'];
        if (value is bool) return value;
      } catch (_) {
        // Eski kurulumlarda yalnızca tablolardan biri bulunabilir.
      }
    }
    return true;
  }

  Future<String> _languageCode() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('app_locale');
    if (saved == 'en' || saved == 'tr') return saved!;
    final systemLanguage =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    return systemLanguage == 'en' ? 'en' : 'tr';
  }

  Future<void> _scheduleWateringNotifications(
    List<Map<String, dynamic>> plants,
    String languageCode,
  ) async {
    if (plants.isEmpty) return;
    final now = tz.TZDateTime.now(tz.local);
    final today = DateTime(now.year, now.month, now.day);
    const hours = [9, 14, 20];
    DateTime? firstDueDate;

    for (final plant in plants) {
      final dueDate = WateringScheduleService.fromPlant(
        plant,
        now: today,
      ).dueDate;
      if (firstDueDate == null || dueDate.isBefore(firstDueDate)) {
        firstDueDate = dueDate;
      }
    }
    if (firstDueDate == null) return;

    final firstReminderDay = firstDueDate.isAfter(today) ? firstDueDate : today;
    for (var slot = 0; slot < hours.length; slot++) {
      var scheduledDate = tz.TZDateTime(
        tz.local,
        firstReminderDay.year,
        firstReminderDay.month,
        firstReminderDay.day,
        hours[slot],
      );
      if (!scheduledDate.isAfter(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      await _notifications.zonedSchedule(
        id: _waterNotificationBaseId + slot,
        title: languageCode == 'en'
            ? 'Your plants are waiting 💧'
            : 'Bitkilerin seni bekliyor 💧',
        body: languageCode == 'en'
            ? 'Don’t forget to water the plants due today.'
            : 'Bugün sulanması gereken bitkilerini sulamayı unutma.',
        payload: 'garden',
        scheduledDate: scheduledDate,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'plant_care_water',
            'Watering reminders',
            channelDescription: 'Reminders for plants that need watering today',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            threadIdentifier: 'plant_care_water',
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  Future<void> _scheduleClinicNotifications(String languageCode) async {
    final now = tz.TZDateTime.now(tz.local);
    const hours = [12, 19];

    for (var slot = 0; slot < hours.length; slot++) {
      var scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hours[slot],
      );
      if (!scheduledDate.isAfter(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      final evening = slot == 1;
      await _notifications.zonedSchedule(
        id: _clinicNotificationBaseId + slot,
        title: languageCode == 'en'
            ? 'Clinic check-up time 🩺'
            : 'Bitki muayene vakti 🩺',
        body: languageCode == 'en'
            ? 'Your sick plant needs attention. You can ask me for help.'
            : evening
            ? 'Hasta bitkinin akşam kontrolü geldi. Bana danışabilirsin.'
            : 'Hasta bitkin ilgi bekliyor. Tedavisi için bana danışabilirsin.',
        payload: 'clinic',
        scheduledDate: scheduledDate,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'plant_care_clinic',
            'Plant clinic reminders',
            channelDescription: 'Check-up reminders for sick plants',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            threadIdentifier: 'plant_care_clinic',
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  void _handleNotificationResponse(NotificationResponse response) {
    _setDestination(response.payload);
  }

  void _setDestination(String? payload) {
    switch (payload) {
      case 'garden':
        destination.value = CareNotificationDestination.garden;
        break;
      case 'clinic':
        destination.value = CareNotificationDestination.clinic;
        break;
    }
  }
}
