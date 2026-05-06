import 'package:flutter/material.dart';
import 'package:mintyn/core/components/custom_button.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/constants/app_size.dart';
import 'package:mintyn/gen/assets.gen.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({required this.balance, super.key});
  final String balance;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GradientBorderPainter(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: Assets.images.cardBg.image().image, fit: BoxFit.cover),
              ),
            ),
            Container(height: 230, color: AppColor.greyT20.withValues(alpha: 0.7), width: double.infinity),
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 9, right: 15),
                    alignment: Alignment.centerRight,
                    child: Assets.images.mastercard.image(height: 36, width: 40),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 37, right: 37),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Balance',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall!.copyWith(color: Colors.white70, fontWeight: FontWeight.w400),
                                ),
                                AppSizes.h(10),
                                Text(
                                  balance,
                                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColor.greyT30,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              alignment: Alignment.center,
                              child: Assets.icons.barcode.svg(
                                height: 20,
                                width: 20,
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                hasLeadingIcon: true,
                                leadingIconPath: Assets.icons.addPlus.path,
                                text: 'Add Cash',
                                textColor: AppColor.white,
                                backgroundColor: const Color(0xFF2563EB),
                                onPressed: () {},
                                borderRadius: 3,
                              ),
                            ),
                            AppSizes.w(30),
                            Expanded(
                              child: CustomButton(
                                hasLeadingIcon: true,
                                leadingIconPath: Assets.icons.arrowUpRight.path,
                                text: 'Send Money',
                                textColor: AppColor.white,
                                backgroundColor: const Color(0xFF2563EB),
                                onPressed: () {},
                                borderRadius: 3,
                              ),
                            ),
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
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(0.5);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(12));

    // --- Stroke 1: Top edge (left → right, white to transparent) ---
    final topPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFE8E8E8), Color(0xFFD0D0D0), Color(0x00000000)],
        stops: [0.0, 0.5, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // --- Stroke 2: Right edge (top → bottom, silver to transparent) ---
    final rightPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE8E8E8), Color(0xFFB0B0B0), Color(0x00000000)],
        stops: [0.0, 0.4, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw full border twice — each shader handles its edge naturally
    canvas.drawRRect(rrect, topPaint);
    canvas.drawRRect(rrect, rightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// class _GradientBorderPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final rect = (Offset.zero & size).deflate(0.5);
//     final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(12));

//     final paint = Paint()
//       ..shader = const LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [
//           Color(0xFFE8E8E8), // bright silver top-left
//           Color(0xFFB0B0B0), // mid silver
//           Color(0x40404040), // semi-transparent dark
//           Color(0x00000000), // fully transparent bottom-right
//         ],
//         stops: [0.0, 0.25, 0.55, 1.0],
//       ).createShader(rect)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.2;

//     canvas.drawRRect(rrect, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
