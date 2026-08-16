import 'package:botaniq/features/healthy/domain/stable_lux_filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StableLuxFilter', () {
    test('rejects a single camera exposure spike', () {
      final filter = StableLuxFilter();

      for (final value in [500.0, 510.0, 495.0, 8000.0, 505.0]) {
        filter.add(value);
      }

      expect(filter.add(500), inInclusiveRange(490, 520));
    });

    test('follows a sustained lighting change', () {
      final filter = StableLuxFilter();
      for (var index = 0; index < 6; index++) {
        filter.add(400);
      }
      for (var index = 0; index < 8; index++) {
        filter.add(4000);
      }

      expect(filter.add(4000), greaterThan(3000));
    });

    test('never returns a negative or non-finite value', () {
      final filter = StableLuxFilter();

      expect(filter.add(double.nan), 0);
      expect(filter.add(-100), 0);
    });
  });
}
