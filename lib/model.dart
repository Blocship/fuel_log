import 'package:isar/isar.dart';

part 'model.g.dart';


@collection
class FuelDataModel {
  final Id id;
  final double distanceTravelled;
  final double fuelPrice;
  final double distanceByFuel;
  final DateTime date;
  final bool isFueledUp;

  FuelDataModel({
    required this.id,
    required this.distanceTravelled,
    required this.fuelPrice,
    required this.distanceByFuel,
    required this.date,
    this.isFueledUp = false,
  });

  FuelDataModel copyWith({
    double? distanceTravelled,
    double? fuelPrice,
    double? distanceByFuel,
    DateTime? date,
    bool? isFueledUp,
  }) {
    return FuelDataModel(
      id: id,
      distanceTravelled: distanceTravelled ?? this.distanceTravelled,
      fuelPrice: fuelPrice ?? this.fuelPrice,
      distanceByFuel: distanceByFuel ?? this.distanceByFuel,
      date: date ?? this.date,
      isFueledUp: isFueledUp ?? this.isFueledUp,
    );
  }


}