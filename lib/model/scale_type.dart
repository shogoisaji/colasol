enum ScaleType {
  scale1,
  scale2,
  scale3,
}

extension GenderExtension on ScaleType {
  static final Map<ScaleType, double> scaleRate = {
    ScaleType.scale1: 1 / 128,
    ScaleType.scale2: 1 / 16,
    ScaleType.scale3: 1
  };

  double get scaleRateValue => scaleRate[this]!;
}
