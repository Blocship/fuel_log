import 'package:flutter/material.dart';
import 'package:fuel_log/model.dart';
import 'package:fuel_log/screen/main_screen.dart';
import 'package:fuel_log/view_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [FuelDataModelSchema],
    directory: dir.path,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel App',
      home: MainScreen(),
    );
  }
}

class FuelListTile extends StatelessWidget {
  final FuelModel fuelModel;

  const FuelListTile({Key? key, required this.fuelModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${fuelModel.distanceTravelled} km',
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      title: Text('Avg: ${fuelModel.distanceByFuel} km/L'),
      subtitle: Text('${fuelModel.fuelPrice} Rs/L'),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('${fuelModel.cost} PKR'),
          Text('${fuelModel.fuelUsed} L'),
        ],
      ),
    );
  }
}
