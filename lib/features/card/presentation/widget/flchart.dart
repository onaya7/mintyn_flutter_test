import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

class FlSpendChartWidget extends StatefulWidget {
  const FlSpendChartWidget({
    required this.title,
    required this.totalAmount,
    required this.spots,
    required this.labels,
    super.key,
    this.periods = const ['Daily', 'Weekly', 'Monthly'],
    this.initialPeriod = 'Weekly',
    this.onPeriodChanged,
  });

  /// Header label, e.g. 'Total Spend'.
  final String title;

  /// Formatted amount string, e.g. '\$3,657'.
  final String totalAmount;

  /// Data points for the line chart. x values should map to [labels] indices.
  final List<FlSpot> spots;

  /// X-axis labels (e.g. month names). Length determines the x-axis range.
  final List<String> labels;

  /// Options shown in the period selector dropdown.
  final List<String> periods;

  /// Which period is selected by default.
  final String initialPeriod;

  /// Called when the user picks a different period — use this to fetch new data.
  final ValueChanged<String>? onPeriodChanged;

  @override
  State<FlSpendChartWidget> createState() => _FlSpendChartWidgetState();
}

class _FlSpendChartWidgetState extends State<FlSpendChartWidget> with SingleTickerProviderStateMixin {
  late String _period;

  late AnimationController _animController;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _period = widget.initialPeriod;
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
    _anim = CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 500),
      decoration: BoxDecoration(
        color: const Color(0xFF212121),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2B7FFF).withValues(alpha: 0.08),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.totalAmount,
                      style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                _PeriodButton(
                  value: _period,
                  options: widget.periods,
                  onChanged: (v) {
                    setState(() => _period = v);
                    widget.onPeriodChanged?.call(v);
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Chart ─────────────────────────────────────────────────
            AnimatedBuilder(
              animation: _anim,
              builder: (context, _) => SizedBox(
                height: 220,
                child: _SpendLineChart(progress: _anim.value, spots: widget.spots, labels: widget.labels),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Chart
// ---------------------------------------------------------------------------

class _SpendLineChart extends StatefulWidget {
  const _SpendLineChart({required this.progress, required this.spots, required this.labels});
  final double progress;
  final List<FlSpot> spots;
  final List<String> labels;

  @override
  State<_SpendLineChart> createState() => _SpendLineChartState();
}

class _SpendLineChartState extends State<_SpendLineChart> {
  // Build the visible spots up to animation progress
  List<FlSpot> get _animatedSpots {
    final source = widget.spots;
    if (source.isEmpty) return [];
    if (widget.progress >= 1.0) return source;
    final maxX = source.last.x * widget.progress;
    final visible = source.where((s) => s.x <= maxX).toList();
    // interpolate last partial segment
    if (visible.length < source.length) {
      final next = source[visible.length];
      final prev = visible.isNotEmpty ? visible.last : source.first;
      final frac = (maxX - prev.x) / (next.x - prev.x);
      visible.add(FlSpot(maxX, prev.y + (next.y - prev.y) * frac));
    }
    return visible;
  }

  @override
  Widget build(BuildContext context) {
    final spots = _animatedSpots;
    final labels = widget.labels;
    final maxX = (labels.length - 1).toDouble();
    final maxY = widget.spots.isEmpty
        ? 100.0
        : ((widget.spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) * 1.2) / 500).ceil() * 500.0;

    return LineChart(
      duration: Duration.zero,
      LineChartData(
        // ── Touch / Tooltip ───────────────────────────────────────
        lineTouchData: LineTouchData(
          touchCallback: (event, response) {
            setState(() {
              if (response == null || response.lineBarSpots == null) {
              } else {}
            });
          },
          getTouchedSpotIndicator: (barData, spotIndexes) {
            return spotIndexes.map((i) {
              return TouchedSpotIndicatorData(
                // Dashed vertical line
                const FlLine(color: Color(0xFFC4C4C4), strokeWidth: 1.2, dashArray: [5, 4]),
                // Dot on line
                FlDotData(
                  getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                    radius: 6,
                    color: const Color(0xFF2B7FFF),
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  ),
                ),
              );
            }).toList();
          },
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => Colors.white,
            tooltipRoundedRadius: 8,
            tooltipPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final value = spot.y;
                final formatted =
                    '\$${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
                return LineTooltipItem(
                  formatted,
                  const TextStyle(color: Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 15),
                );
              }).toList();
            },
          ),
        ),

        // ── Grid ──────────────────────────────────────────────────
        gridData: const FlGridData(show: false),

        // ── Border ────────────────────────────────────────────────
        borderData: FlBorderData(show: false),

        // ── Axes ──────────────────────────────────────────────────
        minX: 0,
        maxX: maxX,
        minY: 0,
        maxY: maxY,

        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= labels.length) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    labels[index],
                    style: const TextStyle(color: Color(0xFFDEDEDE), fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                );
              },
            ),
          ),
        ),

        // ── Line ──────────────────────────────────────────────────
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: const Color(0xFF2B7FFF),
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),

            // Gradient fill under the line
            belowBarData: BarAreaData(
              show: true,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2B7FFF), Color(0x000047B3)],
                stops: [0.0, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Period Dropdown Button
// ---------------------------------------------------------------------------

class _PeriodButton extends StatelessWidget {
  const _PeriodButton({required this.value, required this.options, required this.onChanged});
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) async {
        final box = context.findRenderObject()! as RenderBox;
        final offset = box.localToGlobal(Offset.zero);
        final selected = await showMenu<String>(
          context: context,
          color: const Color(0xFF212121),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          position: RelativeRect.fromLTRB(offset.dx, offset.dy + box.size.height + 6, offset.dx + box.size.width, 0),
          items: options
              .map(
                (o) => PopupMenuItem(
                  value: o,
                  child: Text(o, style: const TextStyle(color: Colors.white, fontSize: 14)),
                ),
              )
              .toList(),
        );
        if (selected != null) onChanged(selected);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF2B7FFF), width: 1.5),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.keyboard_arrow_down, color: Color(0xFF2B7FFF), size: 18),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
