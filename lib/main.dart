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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel App',
      theme: ThemeData.light(useMaterial3: true),
      home: MainScreen(),
    );
  }
}

class FuelListTile extends StatelessWidget {
  final FuelModel fuelModel;
  final VoidCallback onActionPressed;

  const FuelListTile({
    Key? key,
    required this.fuelModel,
    required this.onActionPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0xFFF4F4F4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${fuelModel.distanceTravelled.toPrecision} km',
                    style: const TextStyle(
                      color: Color(0xFF2196F3),
                      fontSize: 30.19,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '${fuelModel.cost.toPrecision} PKR',
                    style: const TextStyle(
                      color: Color(0xFF4E4E4E),
                      fontSize: 20.56,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: onActionPressed,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: CircleBorder(),
                  ),
                  child: Icon(
                    fuelModel.isFueledUp
                        ? Icons.local_gas_station
                        : Icons.local_gas_station_outlined,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TileItem(
                title: 'Average',
                value: fuelModel.distanceByFuel.toPrecision,
                unit: 'km/L',
              ),
              _TileItem(
                title: 'Fuel Consumed',
                value: fuelModel.fuelUsed.toPrecision,
                unit: 'L',
              ),
              _TileItem(
                title: 'Fuel Price',
                value: fuelModel.fuelPrice.toPrecision,
                unit: 'PKR/L',
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TileItem extends StatelessWidget {
  final String title;
  final String value;
  final String unit;

  const _TileItem({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF979797),
            fontSize: 14,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  color: Color(0xFF0D0D0D),
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: unit,
                style: const TextStyle(
                  color: Color(0xFF0D0D0D),
                  fontSize: 10,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
