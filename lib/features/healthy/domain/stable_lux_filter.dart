import 'dart:math' as math;

/// Suppresses single-frame camera exposure spikes while still following a
/// sustained lighting change. The rolling median rejects outliers and the
/// adaptive EMA keeps the displayed number calm without freezing it.
class StableLuxFilter {
  StableLuxFilter({this.windowSize = 5}) : assert(windowSize >= 3);

  final int windowSize;
  final List<double> _samples = [];
  double? _filteredValue;

  int get sampleCount => _samples.length;

  double add(double rawLux) {
    final safeLux = rawLux.isFinite ? math.max(0.0, rawLux) : 0.0;
    _samples.add(safeLux);
    if (_samples.length > windowSize) {
      _samples.removeAt(0);
    }

    final ordered = List<double>.of(_samples)..sort();
    final median = ordered.length.isOdd
        ? ordered[ordered.length ~/ 2]
        : (ordered[ordered.length ~/ 2 - 1] + ordered[ordered.length ~/ 2]) / 2;

    final previous = _filteredValue;
    if (previous == null) {
      _filteredValue = median;
      return median;
    }

    final relativeChange = (median - previous).abs() / math.max(previous, 25);
    final alpha = relativeChange > 0.55 ? 0.48 : 0.18;
    _filteredValue = previous + alpha * (median - previous);
    return _filteredValue!;
  }

  void reset() {
    _samples.clear();
    _filteredValue = null;
  }
}
