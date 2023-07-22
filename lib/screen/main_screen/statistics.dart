part of 'main_screen.dart';

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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 4,
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
                Expanded(
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
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                const SizedBox(width: 8),
                Expanded(
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
