class FuelModel {
  final int id;
  final double distanceTravelled;
  final double fuelPrice;
  final double distanceByFuel;
  final bool isFueledUp;
  final DateTime date;

  FuelModel({
    required this.id,
    required this.distanceTravelled,
    required this.fuelPrice,
    required this.distanceByFuel,
    required this.date,
    this.isFueledUp = false,
  });

  double get fuelUsed => distanceTravelled / distanceByFuel;

  double get cost => fuelUsed * fuelPrice;
}

extension Xnum on num {
  String get toPrecision {
    return toStringAsFixed(truncateToDouble() == this ? 0 : 2);
  }
}
