import 'package:flutter/material.dart';
import 'package:fuel_log/model.dart';
import 'package:fuel_log/repository.dart';
import 'package:fuel_log/screen/add_fuel_screen.dart';
import 'package:fuel_log/screen/settings_screen.dart';
import 'package:fuel_log/view_model.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

part 'fuel_list_tile.dart';
part 'fueled_up_tab.dart';
part 'not_fueled_up_tab.dart';
part 'statistics.dart';

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
                      preferredSize: const Size.fromHeight(268),
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
