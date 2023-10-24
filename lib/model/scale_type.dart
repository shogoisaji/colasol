enum ScaleType {
  scale1,
  scale2,
}

extension GenderExtension on ScaleType {
  static final Map<ScaleType, double> scaleRate = {
    ScaleType.scale1: 1,
    ScaleType.scale2: 1 / 4,
  };

  double get scaleRateValue => scaleRate[this]!;
}
