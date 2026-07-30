import 'package:botaniq/core/services/sick_plant_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SickPlantService.normalizeUrgency', () {
    test('normalizes Turkish urgency values', () {
      expect(SickPlantService.normalizeUrgency('Düşük'), 'Düşük');
      expect(SickPlantService.normalizeUrgency('Orta'), 'Orta');
      expect(SickPlantService.normalizeUrgency('Kritik'), 'Kritik');
    });

    test('normalizes common English model responses', () {
      expect(SickPlantService.normalizeUrgency('low'), 'Düşük');
      expect(SickPlantService.normalizeUrgency('medium'), 'Orta');
      expect(SickPlantService.normalizeUrgency('critical'), 'Kritik');
      expect(SickPlantService.normalizeUrgency('high urgency'), 'Kritik');
    });

    test('uses medium as a safe fallback', () {
      expect(SickPlantService.normalizeUrgency(null), 'Orta');
      expect(SickPlantService.normalizeUrgency('unknown'), 'Orta');
    });
  });
}
