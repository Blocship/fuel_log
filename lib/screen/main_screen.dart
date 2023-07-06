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
        body: SafeArea(
          bottom: false,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: ScrollableHeaderDelegate(
                    child: PreferredSize(
                      preferredSize: const Size.fromHeight(268), // 120
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Statistics(
                            repo: repo,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                child: Divider(
                                  thickness: 2,
                                ),
                              ),
                            ),
                          ),
                          ColoredBox(
                            color: Colors.grey[200]!,
                            child: const TabBar(
                              labelColor: Color(0xFF2C2C2C),
                              indicator: UnderlineTabIndicator(
                                borderSide: BorderSide(
                                  color: Color(0xFF2C2C2C),
                                  width: 2.0,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                insets: EdgeInsets.symmetric(horizontal: 56.0),
                              ),
                              tabs: [
                                Tab(
                                  icon: Icon(Icons.local_gas_station_outlined),
                                ),
                                Tab(
                                  icon: Icon(Icons.local_gas_station),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    visibleSpaceHeight: 68,
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                NotFueledUpTab(repo: repo),
                FueledUpTab(repo: repo),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScrollableHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;
  final double visibleSpaceHeight;

  ScrollableHeaderDelegate({
    required this.child,
    required this.visibleSpaceHeight,
  });

  final ScrollController controller = ScrollController();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // final progress = shrinkOffset / maxExtent;
    // bool isMinimized = (shrinkOffset >= (maxExtent - minExtent));
    return OverflowBox(
      maxHeight: maxExtent,
      alignment: Alignment.bottomCenter,
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => visibleSpaceHeight;

  @override
  bool shouldRebuild(covariant ScrollableHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.visibleSpaceHeight != visibleSpaceHeight;
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
            // Statistics(repo: widget.repo),
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
                          child: FuelListTile(
                            fuelModel: fuelModel,
                            onActionPressed: () {
                              widget.repo.markAsFueledUp(fuelModel.id);
                            },
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
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
                return FuelListTile(
                  fuelModel: fuelModel,
                  onActionPressed: () {
                    widget.repo.markAsNotFueledUp(fuelModel.id);
                  },
                );
              },
            );
          }),
    );
  }
}

class Statistics extends StatefulWidget implements PreferredSizeWidget {
  final FuelRepository repo;
  const Statistics({
    Key? key,
    required this.repo,
  }) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();

  @override
  Size get preferredSize => const Size.fromHeight(200);
}

class _StatisticsState extends State<Statistics> {
  late final Stream<double> streamTotalCost;
  late final Stream<double> streamTotalDistance;
  late final Stream<double> streamFuelConsumed;

  @override
  void initState() {
    super.initState();
    streamTotalCost = widget.repo.totalCostOfNotFueledUp();
    streamTotalDistance = widget.repo.totalDistanceOfNotFueledUp();
    streamFuelConsumed = widget.repo.totalFuelConsumedOfNotFueledUp();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _StatContainer(
                    child: StreamBuilder<double>(
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
                            value: totalCost.toPrecision,
                            unit: 'Rs',
                          );
                        }),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _StatContainer(
                    child: StreamBuilder<double>(
                        stream: streamFuelConsumed,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const _StatItem(
                              label: 'Fuel Consumed',
                              value: '0.0',
                              unit: 'L',
                            );
                          }
                          final fuelConsumed = snapshot.data!;
                          return _StatItem(
                            label: 'Fuel Consumed',
                            value: fuelConsumed.toPrecision,
                            unit: 'L',
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
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
                      icon: const Icon(
                        Icons.menu,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: _StatContainer(
                    child: StreamBuilder<double>(
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
                            value: totalDistance.toPrecision,
                            unit: 'Km',
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatContainer extends StatelessWidget {
  final Widget child;

  const _StatContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x332196F3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
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

// child: Scaffold(
//   body: CustomScrollView(
//     slivers: [
//       SliverPersistentHeader(
//         pinned: true,
//         delegate: HeaderDelegate(),
//       ),
//       // dummy slivers
//       SliverToBoxAdapter(
//         child: Container(
//           height: 200,
//           color: Colors.blue,
//         ),
//       ),
//       SliverToBoxAdapter(
//         child: Container(
//           height: 200,
//           color: Colors.green,
//         ),
//       ),
//       SliverToBoxAdapter(
//         child: Container(
//           height: 200,
//           color: Colors.yellow,
//         ),
//       ),
//       SliverToBoxAdapter(
//         child: Container(
//           height: 200,
//           color: Colors.purple,
//         ),
//       ),
//       SliverToBoxAdapter(
//         child: Container(
//           height: 200,
//           color: Colors.orange,
//         ),
//       ),
//     ],
//   ),
// ),

//       child: Scaffold(
//   appBar: AppBar(
//     actions: [
//       IconButton(
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => SettingsScreen(
//                 repo: repo,
//               ),
//             ),
//           );
//         },
//         icon: const Icon(
//           Icons.menu,
//         ),
//       ),
//     ],
//     bottom: const TabBar(
//       labelColor: Color(0xFF2C2C2C),
//       indicator: UnderlineTabIndicator(
//         borderSide: BorderSide(
//           color: Color(0xFF2C2C2C),
//           width: 2.0,
//         ),
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//         insets: EdgeInsets.symmetric(horizontal: 56.0),
//       ),
//       tabs: [
//         Tab(
//           icon: Icon(Icons.local_gas_station_outlined),
//         ),
//         Tab(
//           icon: Icon(Icons.local_gas_station),
//         ),
//       ],
//     ),
//   ),
//   body: TabBarView(
//     children: [
//       NotFueledUpTab(
//         repo: repo,
//       ),
//       FueledUpTab(
//         repo: repo,
//       ),
//     ],
//   ),
// ),
