import 'package:flutter/material.dart';
import 'package:fuel_log/main.dart';
import 'package:fuel_log/model.dart';
import 'package:fuel_log/repository.dart';
import 'package:fuel_log/screen/add_fuel_screen.dart';
import 'package:fuel_log/screen/settings_screen.dart';
import 'package:fuel_log/view_model.dart';
import 'package:isar/isar.dart';

class MainScreen extends StatelessWidget {
  final repo = FuelRepository(Isar.getInstance()!);

  MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Fuel App',
          ),
          actions: [
            // Hamburger leading to Settings Screen
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(
                        repo: repo,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.directions_railway_filled_rounded))
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Not Fuel Up',
              ),
              Tab(
                text: 'Fuel Up',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NotFueledUpTab(repo: repo),
            FueledUpTab(
              repo: repo,
            ),
          ],
        ),
      ),
    );
  }
}

class NotFueledUpTab extends StatefulWidget {
  final FuelRepository repo;
  const NotFueledUpTab({
    Key? key,
    required this.repo,
  }) : super(key: key);

  @override
  _NotFueledUpTabState createState() => _NotFueledUpTabState();
}

class _NotFueledUpTabState extends State<NotFueledUpTab> {
  late final Stream<List<FuelModel>> streamNotFueledUp;
  late final Stream<double> streamTotalCost;
  @override
  void initState() {
    super.initState();
    streamNotFueledUp = widget.repo.notFueledUp();
    streamTotalCost = widget.repo.totalCostOfNotFueledUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<FuelModel>>(
                  stream: streamNotFueledUp,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final dummyList = snapshot.data!;
                    print("rebuild check");
                    return ListView.builder(
                      itemCount: dummyList.length,
                      itemBuilder: (context, index) {
                        final fuelModel = dummyList[index];
                        return Dismissible(
                          key: ValueKey(fuelModel.id),
                          onDismissed: (direction) {
                            widget.repo.markAsFueledUp(fuelModel.id);
                          },
                          child: FuelListTile(fuelModel: fuelModel),
                        );
                      },
                    );
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder<double>(
                      stream: streamTotalCost,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Text('Total Cost: 0.0');
                        }
                        final totalCost = snapshot.data!;
                        return Text('Total Cost: $totalCost');
                      }),
                  // Text('Total Distance: $totalDistance'),
                  // Text('Total Fuel Used: $totalFuelUsed'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final fuelModel = await Navigator.push<FuelDataModel>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddFuelScreen(),
            ),
          );
          if (fuelModel != null) {
            setState(() {
              widget.repo.addFuel(fuelModel);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FueledUpTab extends StatefulWidget {
  final FuelRepository repo;
  const FueledUpTab({
    Key? key,
    required this.repo,
  }) : super(key: key);

  @override
  _FueledUpTabState createState() => _FueledUpTabState();
}

class _FueledUpTabState extends State<FueledUpTab> {
  late final Stream<List<FuelModel>> streamFueledUp;

  @override
  void initState() {
    super.initState();
    streamFueledUp = widget.repo.fueledUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<FuelModel>>(
          stream: streamFueledUp,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final dummyList = snapshot.data!;
            return ListView.builder(
              itemCount: dummyList.length,
              itemBuilder: (context, index) {
                final fuelModel = dummyList[index];
                return FuelListTile(fuelModel: fuelModel);
              },
            );
          }),
    );
  }
}
