import 'package:fuel_log/model.dart';
import 'package:fuel_log/view_model.dart';
import 'package:isar/isar.dart';

///
class FuelRepository {
  final Isar _isar;
  final IsarCollection<FuelDataModel> _collection;

  FuelRepository(Isar isar)
      : _isar = isar,
        _collection = isar.collection<FuelDataModel>();

  Future<void> addFuel(FuelDataModel model) async {
    await _isar.writeTxn(() async {
      final id = await _collection.put(model);
      print('Added fuel with id: ${id}');
    });
  }

  Future<void> markAsFueledUp(Id id) async {
    await _isar.writeTxn(() async {
      final model = await _collection.get(id);
      if (model != null) {
        final newModel = model.copyWith(isFueledUp: true);
        final id = await _collection.put(newModel);
        print('Marked fuel with id: ${id} as fueled up');
      }
    });
  }

  Future<void> markAsNotFueledUp(Id id) async {
    await _isar.writeTxn(() async {
      final model = await _collection.get(id);
      if (model != null) {
        final newModel = model.copyWith(isFueledUp: false);
        final id = await _collection.put(newModel);
        print('Marked fuel with id: ${id} as not fueled up');
      }
    });
  }

  Stream<List<FuelModel>> all() {
    return _collection.where().watch(fireImmediately: true).map((list) {
      return list.map((model) {
        return FuelModel(
          id: model.id,
          distanceTravelled: model.distanceTravelled,
          fuelPrice: model.fuelPrice,
          distanceByFuel: model.distanceByFuel,
          isFueledUp: model.isFueledUp,
          date: model.date,
        );
      }).toList();
    });
  }

  Stream<List<FuelModel>> fueledUp() {
    return _collection
        .where()
        .filter()
        .isFueledUpEqualTo(true)
        .build()
        .watch(fireImmediately: true)
        .map((list) {
      return list.map((model) {
        return FuelModel(
          id: model.id,
          distanceTravelled: model.distanceTravelled,
          fuelPrice: model.fuelPrice,
          distanceByFuel: model.distanceByFuel,
          isFueledUp: model.isFueledUp,
          date: model.date,
        );
      }).toList();
    });
  }

  Stream<List<FuelModel>> notFueledUp() {
    return _collection
        .where()
        .filter()
        .isFueledUpEqualTo(false)
        .build()
        .watch(fireImmediately: true)
        .map((list) {
      return list.map((model) {
        return FuelModel(
          id: model.id,
          distanceTravelled: model.distanceTravelled,
          fuelPrice: model.fuelPrice,
          distanceByFuel: model.distanceByFuel,
          isFueledUp: model.isFueledUp,
          date: model.date,
        );
      }).toList();
    });
  }

  Stream<double> totalCostOfNotFueledUp() {
    return _collection
        .where()
        .filter()
        .isFueledUpEqualTo(false)
        .build()
        .watch(fireImmediately: true)
        .map((list) {
      return list.map((model) {
        return FuelModel(
          id: model.id,
          distanceTravelled: model.distanceTravelled,
          fuelPrice: model.fuelPrice,
          distanceByFuel: model.distanceByFuel,
          isFueledUp: model.isFueledUp,
          date: model.date,
        );
      }).toList();
    }).map((list) {
      return list.fold(
          0, (previousValue, element) => previousValue + element.cost);
    });
  }

  Stream<double> totalDistanceOfNotFueledUp() {
    return _collection
        .where()
        .filter()
        .isFueledUpEqualTo(false)
        .build()
        .watch(fireImmediately: true)
        .map((list) {
      return list.map((model) {
        return FuelModel(
          id: model.id,
          distanceTravelled: model.distanceTravelled,
          fuelPrice: model.fuelPrice,
          distanceByFuel: model.distanceByFuel,
          isFueledUp: model.isFueledUp,
          date: model.date,
        );
      }).toList();
    }).map((list) {
      return list.fold(
        0,
        (previousValue, element) => previousValue + element.distanceTravelled,
      );
    });
  }

  // final totalCost = dummyList.fold(
  //     0.0, (previousValue, element) => previousValue + element.fuelPrice);
  // final totalDistance = dummyList.fold(0.0,
  //     (previousValue, element) => previousValue + element.distanceTravelled);
  // final totalFuelUsed = dummyList.fold(
  //     0.0, (previousValue, element) => previousValue + element.fuelUsed);

  Future<void> dispose() async {}
}
