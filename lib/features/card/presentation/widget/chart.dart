import 'dart:math';

import 'package:flutter/material.dart';

class SpendChartWidget extends StatefulWidget {
  const SpendChartWidget({
    required this.title,
    required this.totalAmount,
    required this.dataPoints,
    required this.labels,
    super.key,
    this.periods = const ['Daily', 'Weekly', 'Monthly'],
    this.initialPeriod = 'Weekly',
    this.onPeriodChanged,
    this.tooltipValueBuilder,
  });

  /// Header label, e.g. "Total Spend"
  final String title;

  /// Amount shown next to the title, e.g. "\$30"
  final String totalAmount;

  /// Normalised data values (0.0–1.0) — one per chart point
  final List<double> dataPoints;

  /// X-axis labels, e.g. ['Jan', 'Feb', 'Mar']
  final List<String> labels;

  /// Period selector options
  final List<String> periods;

  /// Which period is selected on first render
  final String initialPeriod;

  /// Called when the user picks a different period
  final ValueChanged<String>? onPeriodChanged;

  /// Optional: build the tooltip string from (index, normalised value).
  /// Defaults to a derived dollar amount when null.
  final String Function(int index, double value)? tooltipValueBuilder;

  @override
  State<SpendChartWidget> createState() => _SpendChartWidgetState();
}

class _SpendChartWidgetState extends State<SpendChartWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  late String _selectedPeriod;

  // Tooltip state
  double? _tooltipX;
  double? _tooltipY;
  String? _tooltipValue;
  int? _hoverIndex;

  @override
  void initState() {
    super.initState();
    _selectedPeriod = widget.initialPeriod;
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void didUpdateWidget(SpendChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dataPoints != widget.dataPoints) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 480),
      decoration: BoxDecoration(
        color: const Color(0xFF212121),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.totalAmount,
                      style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                // Period dropdown button
                _PeriodDropdown(
                  value: _selectedPeriod,
                  options: widget.periods,
                  onChanged: (val) {
                    setState(() => _selectedPeriod = val);
                    widget.onPeriodChanged?.call(val);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Chart area
            AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return _ChartArea(
                  dataPoints: widget.dataPoints,
                  labels: widget.labels,
                  progress: _animation.value,
                  tooltipValueBuilder: widget.tooltipValueBuilder,
                  tooltipX: _tooltipX,
                  tooltipY: _tooltipY,
                  tooltipValue: _tooltipValue,
                  hoverIndex: _hoverIndex,
                  onHover: (x, y, value, index) {
                    setState(() {
                      _tooltipX = x;
                      _tooltipY = y;
                      _tooltipValue = value;
                      _hoverIndex = index;
                    });
                  },
                  onHoverEnd: () {
                    setState(() {
                      _tooltipX = null;
                      _tooltipY = null;
                      _tooltipValue = null;
                      _hoverIndex = null;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PeriodDropdown extends StatelessWidget {
  const _PeriodDropdown({required this.value, required this.options, required this.onChanged});
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
          position: RelativeRect.fromLTRB(offset.dx, offset.dy + box.size.height + 4, offset.dx + box.size.width, 0),
          color: const Color(0xFF212121),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
            const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
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

class _ChartArea extends StatelessWidget {
  const _ChartArea({
    required this.dataPoints,
    required this.labels,
    required this.progress,
    required this.tooltipX,
    required this.tooltipY,
    required this.tooltipValue,
    required this.hoverIndex,
    required this.onHover,
    required this.onHoverEnd,
    this.tooltipValueBuilder,
  });
  final List<double> dataPoints;
  final List<String> labels;
  final double progress;
  final double? tooltipX;
  final double? tooltipY;
  final String? tooltipValue;
  final int? hoverIndex;
  final void Function(double, double, String, int) onHover;
  final VoidCallback onHoverEnd;
  final String Function(int index, double value)? tooltipValueBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GestureDetector(
                onPanUpdate: (details) => _handleInteraction(details.localPosition, constraints),
                onPanEnd: (_) => onHoverEnd(),
                onTapDown: (details) => _handleInteraction(details.localPosition, constraints),
                child: CustomPaint(
                  size: Size(constraints.maxWidth, 220),
                  painter: _SpendChartPainter(
                    dataPoints: dataPoints,
                    progress: progress,
                    tooltipX: tooltipX,
                    tooltipY: tooltipY,
                    tooltipValue: tooltipValue,
                    hoverIndex: hoverIndex,
                  ),
                ),
              );
            },
          ),
        ),
        // X-axis labels
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: labels
                .map(
                  (l) => Text(
                    l,
                    style: const TextStyle(color: Color(0xFFC4C4C4), fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  void _handleInteraction(Offset pos, BoxConstraints constraints) {
    final width = constraints.maxWidth;
    const chartTop = 10.0;
    const chartBottom = 200.0;

    // Find nearest point index
    final step = width / (dataPoints.length - 1);
    final nearestIndex = (pos.dx / step).round().clamp(0, dataPoints.length - 1);

    final x = nearestIndex * step;
    final y = chartTop + (chartBottom - chartTop) * (1 - dataPoints[nearestIndex]) * progress;

    final value = tooltipValueBuilder != null
        ? tooltipValueBuilder!(nearestIndex, dataPoints[nearestIndex])
        : '\$${(1000 + dataPoints[nearestIndex] * 5000).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';

    onHover(x, y, value, nearestIndex);
  }
}

class _SpendChartPainter extends CustomPainter {
  _SpendChartPainter({
    required this.dataPoints,
    required this.progress,
    required this.tooltipX,
    required this.tooltipY,
    required this.tooltipValue,
    required this.hoverIndex,
  });
  final List<double> dataPoints;
  final double progress;
  final double? tooltipX;
  final double? tooltipY;
  final String? tooltipValue;
  final int? hoverIndex;

  @override
  void paint(Canvas canvas, Size size) {
    const chartTop = 10.0;
    final chartBottom = size.height - 20;
    final chartHeight = chartBottom - chartTop;
    final step = size.width / (dataPoints.length - 1);

    final points = <Offset>[];
    for (var i = 0; i < dataPoints.length; i++) {
      final x = i * step;
      final y = chartTop + chartHeight * (1 - dataPoints[i]);
      points.add(Offset(x, y));
    }

    // Apply animation progress — clip points
    final visibleCount = (points.length * progress).ceil().clamp(2, points.length);
    final animatedPoints = points.sublist(0, visibleCount);

    // Interpolate last point for smooth animation
    if (visibleCount < points.length) {
      final frac = (points.length * progress) - (visibleCount - 1);
      final prev = points[visibleCount - 2];
      final curr = points[visibleCount - 1];
      animatedPoints[visibleCount - 1] = Offset(
        prev.dx + (curr.dx - prev.dx) * frac,
        prev.dy + (curr.dy - prev.dy) * frac,
      );
    }

    // Build smooth path using cubic bezier
    final linePath = _buildSmoothPath(animatedPoints);

    // Filled area path
    final fillPath = Path.from(linePath);
    fillPath.lineTo(animatedPoints.last.dx, chartBottom);
    fillPath.lineTo(animatedPoints.first.dx, chartBottom);
    fillPath.close();

    // Gradient fill — Figma: #2B7FFF (100%) → #0047B3 (0%)
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [const Color(0xFF2B7FFF), const Color(0xFF0047B3).withValues(alpha: 0)],
      ).createShader(Rect.fromLTWH(0, chartTop, size.width, chartHeight))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // Line stroke
    final linePaint = Paint()
      ..color = const Color(0xFF2B7FFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(linePath, linePaint);

    // Hover elements
    if (tooltipX != null && tooltipY != null && tooltipValue != null) {
      // Dashed vertical line
      _drawDashedLine(
        canvas,
        Offset(tooltipX!, chartTop),
        Offset(tooltipX!, chartBottom),
        const Color(0xFFFFFFFF),
        0.35,
      );

      // Dot
      final dotPaint = Paint()
        ..color = const Color(0xFF2B7FFF)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(tooltipX!, tooltipY!), 7, dotPaint);
      final dotBorder = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawCircle(Offset(tooltipX!, tooltipY!), 7, dotBorder);

      // Tooltip box
      _drawTooltip(canvas, size, tooltipX!, tooltipY!, tooltipValue!);
    }
  }

  Path _buildSmoothPath(List<Offset> points) {
    final path = Path();
    if (points.isEmpty) return path;
    path.moveTo(points[0].dx, points[0].dy);

    for (var i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlX1 = p0.dx + (p1.dx - p0.dx) / 3;
      final controlX2 = p1.dx - (p1.dx - p0.dx) / 3;
      path.cubicTo(controlX1, p0.dy, controlX2, p1.dy, p1.dx, p1.dy);
    }
    return path;
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Color color, double opacity) {
    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const dashLength = 5.0;
    const gapLength = 4.0;
    final totalLength = (end - start).distance;
    final direction = (end - start) / totalLength;
    double drawn = 0;

    while (drawn < totalLength) {
      final segEnd = min(drawn + dashLength, totalLength);
      canvas.drawLine(start + direction * drawn, start + direction * segEnd, paint);
      drawn += dashLength + gapLength;
    }
  }

  void _drawTooltip(Canvas canvas, Size size, double x, double y, String value) {
    const tooltipW = 100.0;
    const tooltipH = 38.0;

    var tx = x + 12;
    if (tx + tooltipW > size.width) tx = x - tooltipW - 12;

    final ty = y - tooltipH / 2;

    final rrect = RRect.fromRectAndRadius(Rect.fromLTWH(tx, ty, tooltipW, tooltipH), const Radius.circular(8));

    // Shadow
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );

    // Background
    canvas.drawRRect(rrect, Paint()..color = Colors.white);

    // Text
    final tp = TextPainter(
      text: TextSpan(
        text: value,
        style: const TextStyle(color: Color(0xFF212121), fontSize: 15, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    tp.paint(canvas, Offset(tx + (tooltipW - tp.width) / 2, ty + (tooltipH - tp.height) / 2));
  }

  @override
  bool shouldRepaint(covariant _SpendChartPainter old) =>
      old.progress != progress || old.tooltipX != tooltipX || old.hoverIndex != hoverIndex;
}
