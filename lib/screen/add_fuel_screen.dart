import 'package:flutter/material.dart';
import 'package:fuel_log/model.dart';
import 'package:isar/isar.dart';

class AddFuelScreen extends StatefulWidget {
  const AddFuelScreen({Key? key}) : super(key: key);

  @override
  _AddFuelScreenState createState() => _AddFuelScreenState();
}

class _AddFuelScreenState extends State<AddFuelScreen> {
  final _formKey = GlobalKey<FormState>();
  final _distanceTravelledController = TextEditingController();
  final _fuelPriceController = TextEditingController();
  final _distanceByFuelController = TextEditingController();

  @override
  void dispose() {
    _distanceTravelledController.dispose();
    _fuelPriceController.dispose();
    _distanceByFuelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Add Fuel'),
        title: const Text('Add Fuel'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _distanceTravelledController,
                decoration: const InputDecoration(
                  labelText: 'Distance Travelled (Km)',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter distance travelled';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fuelPriceController,
                decoration: const InputDecoration(
                  labelText: 'Fuel Price (PKR/L)',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter fuel price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _distanceByFuelController,
                decoration: const InputDecoration(
                  labelText: 'Fuel Average (Km/L)',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter distance by fuel';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final fuelModel = FuelDataModel(
                      id: Isar.autoIncrement,
                      date: DateTime.now(),
                      distanceTravelled:
                          double.parse(_distanceTravelledController.text),
                      fuelPrice: double.parse(_fuelPriceController.text),
                      distanceByFuel:
                          double.parse(_distanceByFuelController.text),
                    );
                    Navigator.pop(context, fuelModel);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
