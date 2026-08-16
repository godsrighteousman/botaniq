import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Keeps every social sign-in entry point on the same native authentication
/// flow and makes provider logout a best-effort companion to Supabase logout.
class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  static const String _googleWebClientId = String.fromEnvironment(
    'GOOGLE_WEB_CLIENT_ID',
  );
  static const String _googleIosClientId = String.fromEnvironment(
    'GOOGLE_IOS_CLIENT_ID',
  );

  late final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: _googleClientId,
    serverClientId: _googleServerClientId,
  );

  String? get _googleClientId {
    if (kIsWeb) {
      return _googleWebClientId.isEmpty ? null : _googleWebClientId;
    }
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      return _googleIosClientId.isEmpty ? null : _googleIosClientId;
    }
    return null;
  }

  String? get _googleServerClientId {
    final webClientId = _googleWebClientId.trim();
    if (webClientId.isEmpty) {
      return null;
    }

    // Google requires the server client to be a separate Web OAuth client.
    // Passing the iOS client a second time as the server client makes the
    // native SDK reject an otherwise valid iOS configuration. In that case,
    // let the SDK issue an ID token for the native client instead.
    if ((defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS) &&
        webClientId == _googleIosClientId.trim()) {
      return null;
    }
    return webClientId;
  }

  bool get supportsAppleSignIn =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS);

  /// Returns false when the user closes the Google account picker.
  Future<bool> signInWithGoogle() async {
    debugPrint('[Auth][Google] Native account picker starting.');
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      debugPrint('[Auth][Google] Account picker canceled.');
      return false;
    }

    debugPrint('[Auth][Google] Account selected; requesting tokens.');
    final googleAuth = await googleUser.authentication;
    final idToken = googleAuth.idToken;
    debugPrint(
      '[Auth][Google] Tokens received: '
      'idToken=${idToken?.isNotEmpty == true}, '
      'accessToken=${googleAuth.accessToken?.isNotEmpty == true}.',
    );
    if (idToken == null || idToken.isEmpty) {
      throw const AuthException(
        'Google kimlik belirteci alınamadı. OAuth istemci ayarlarını kontrol edin.',
      );
    }

    debugPrint('[Auth][Google] Sending ID token to Supabase.');
    await Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: googleAuth.accessToken,
    );
    debugPrint('[Auth][Google] Supabase session created.');
    return true;
  }

  /// Returns false when the user cancels Apple's authorization sheet.
  Future<bool> signInWithApple() async {
    debugPrint('[Auth][Apple] Native authorization starting.');
    if (!supportsAppleSignIn || !await SignInWithApple.isAvailable()) {
      throw const AuthException('Apple ile giriş bu cihazda kullanılamıyor.');
    }

    final rawNonce = Supabase.instance.client.auth.generateRawNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: const [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );
      final idToken = credential.identityToken;
      debugPrint(
        '[Auth][Apple] Credential received: '
        'idToken=${idToken?.isNotEmpty == true}.',
      );
      if (idToken == null || idToken.isEmpty) {
        throw const AuthException('Apple kimlik belirteci alınamadı.');
      }

      debugPrint('[Auth][Apple] Sending ID token to Supabase.');
      await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
        nonce: rawNonce,
      );
      debugPrint('[Auth][Apple] Supabase session created.');

      await _saveAppleDisplayName(credential);
      return true;
    } on SignInWithAppleAuthorizationException catch (error) {
      if (error.code == AuthorizationErrorCode.canceled) {
        debugPrint('[Auth][Apple] Authorization canceled.');
        return false;
      }
      debugPrint('[Auth][Apple] Native authorization failed: $error');
      rethrow;
    } catch (error, stackTrace) {
      debugPrint('[Auth][Apple] Supabase sign-in failed: $error\n$stackTrace');
      rethrow;
    }
  }

  Future<void> _saveAppleDisplayName(
    AuthorizationCredentialAppleID credential,
  ) async {
    final fullName = [
      credential.givenName?.trim(),
      credential.familyName?.trim(),
    ].whereType<String>().where((part) => part.isNotEmpty).join(' ');
    if (fullName.isEmpty) {
      return;
    }

    // Apple only shares the name on the first authorization. Persist it in
    // auth metadata immediately; the existing DB trigger mirrors it to the
    // application profile tables.
    await Supabase.instance.client.auth.updateUser(
      UserAttributes(data: {'full_name': fullName}),
    );
  }

  Future<void> signOut() async {
    Object? supabaseError;
    try {
      await Supabase.instance.client.auth
          .signOut(scope: SignOutScope.local)
          .timeout(const Duration(seconds: 10));
    } catch (error, stackTrace) {
      supabaseError = error;
      debugPrint('Supabase sign-out warning: $error\n$stackTrace');
    }

    try {
      await _googleSignIn.signOut();
    } catch (error, stackTrace) {
      // A user who signed in with email or Apple may not have a Google session.
      debugPrint('Google sign-out warning: $error\n$stackTrace');
    }

    // GoTrue clears local session state before its network revocation request.
    // Only surface the network error when local logout genuinely did not occur.
    if (Supabase.instance.client.auth.currentSession != null &&
        supabaseError != null) {
      throw supabaseError;
    }
  }
}
