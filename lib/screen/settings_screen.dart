import 'package:flutter/material.dart';
import 'package:fuel_log/repository.dart';

class SettingsScreen extends StatefulWidget {
  final FuelRepository repo;

  SettingsScreen({
    Key? key,
    required this.repo,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              title: const Text('Fuel Efficiency'),
              subtitle: const Text('Enter your fuel efficiency'),
              trailing: SizedBox(
                width: 100,
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // widget.repo.fuelEfficiency = double.parse(value!);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
