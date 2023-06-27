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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.paddingOf(context).top + kTextTabBarHeight,
          ),
          child: const SafeArea(
            child: TabBar(
              labelColor: Color(0xFF2C2C2C),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Color(0xFF2C2C2C),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                insets: EdgeInsets.symmetric(horizontal: 56.0),
              ),
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
            Statistics(repo: widget.repo),
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
                          direction: DismissDirection.startToEnd,
                          child: FuelListTile(fuelModel: fuelModel),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton.small(
            heroTag: null,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                    repo: widget.repo,
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.local_gas_station,
            ),
          ),
          FloatingActionButton(
            heroTag: null,
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
        ],
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

class Statistics extends StatefulWidget {
  final FuelRepository repo;
  const Statistics({
    Key? key,
    required this.repo,
  }) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late final Stream<double> streamTotalCost;
  late final Stream<double> streamTotalDistance;

  @override
  void initState() {
    super.initState();
    streamTotalCost = widget.repo.totalCostOfNotFueledUp();
    streamTotalDistance = widget.repo.totalDistanceOfNotFueledUp();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x332196F3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StreamBuilder<double>(
              stream: streamTotalCost,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const _StatItem(
                    label: 'Total Cost',
                    value: '0.0',
                    unit: 'Rs',
                  );
                }
                final totalCost = snapshot.data!;
                return _StatItem(
                  label: 'Total Cost',
                  value: '$totalCost',
                  unit: 'Rs',
                );
              }),
          Container(
            width: 2,
            height: 55.33,
            decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.800000011920929),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          StreamBuilder<double>(
              stream: streamTotalDistance,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const _StatItem(
                    label: 'Total Distance',
                    value: '0.0',
                    unit: 'Km',
                  );
                }
                final totalDistance = snapshot.data!;
                return _StatItem(
                  label: 'Total Distance',
                  value: '$totalDistance',
                  unit: 'Km',
                );
              }),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const _StatItem({
    Key? key,
    required this.label,
    required this.value,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  color: Color(0xFF0D0D0D),
                  fontSize: 22,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const TextSpan(
                text: ' ',
                style: TextStyle(
                  color: Color(0xFF0D0D0D),
                  fontSize: 20,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: unit,
                style: const TextStyle(
                  color: Color(0xFF8B8B8B),
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF595959),
            fontSize: 14,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
