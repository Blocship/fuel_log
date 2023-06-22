class FuelModel {
  final int id;
  final double distanceTravelled;
  final double fuelPrice;
  final double distanceByFuel;
  final bool isFueledUp;

  FuelModel({
    required this.id,
    required this.distanceTravelled,
    required this.fuelPrice,
    required this.distanceByFuel,
    this.isFueledUp = false,
  });

  double get fuelUsed => distanceTravelled / distanceByFuel;

  double get cost => fuelUsed * fuelPrice;
}