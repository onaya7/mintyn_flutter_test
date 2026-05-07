import 'package:flutter/material.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/gen/assets.gen.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    required this.lastFour,
    required this.holder,
    required this.validDate,
    required this.cvv,
    super.key,
  });

  final String lastFour;
  final String holder;
  final String validDate;
  final String cvv;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CardBorderPainter(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 196,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image(image: Assets.images.cardBg.image().image, fit: BoxFit.cover),
              ),
              Positioned.fill(child: Container(color: AppColor.greyT20.withValues(alpha: 0.6))),
              Positioned.fill(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 6, right: 12),
                      alignment: Alignment.topRight,
                      child: Assets.images.mastercard.image(height: 32, width: 36),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Assets.images.cardcomp.image(height: 42, width: 69),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: '•••• •••• •••• ',
                              style: const TextStyle(
                                color: AppColor.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 3,
                              ),
                              children: [
                                TextSpan(
                                  text: lastFour,
                                  style: const TextStyle(
                                    color: AppColor.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            spacing: 20,
                            children: [
                              _CardDetail(label: 'Card Holder', value: holder),
                              _CardDetail(label: 'Valid', value: validDate),
                              _CardDetail(label: 'CVV', value: cvv),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardDetail extends StatelessWidget {
  const _CardDetail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColor.greyT70,
            fontSize: 11,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(color: AppColor.white, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _CardBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(0.5);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(12));

    final topPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFE8E8E8), Color(0xFFD0D0D0), Color(0x00000000)],
        stops: [0.0, 0.5, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final rightPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE8E8E8), Color(0xFFB0B0B0), Color(0x00000000)],
        stops: [0.0, 0.4, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRRect(rrect, topPaint);
    canvas.drawRRect(rrect, rightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
