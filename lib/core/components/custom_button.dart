import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mintyn/core/constants/app_color.dart';
import 'package:mintyn/core/helpers/ui_helpers.dart';
import 'package:mintyn/gen/assets.gen.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.onPressed,
    this.textFontWeight = FontWeight.w600,
    this.textSize = 16,
    this.sufficIconPath,
    this.leadingIconPath,
    this.leadingImagePath,
    this.iconWidth = 24,
    this.suffixIconColor = AppColor.white,
    this.leadingIconColor = AppColor.white,
    this.iconHeight = 24,
    this.hasLeadingIcon = false,
    this.useLeadingImage = false,
    this.hasSuffixIcon = false,
    this.borderColor,
    this.borderRadius = 100,
    this.height = 48,
    this.isLoading = false,
    super.key,
  });

  final String text;
  final Color textColor;
  final double textSize;
  final FontWeight? textFontWeight;
  final String? sufficIconPath;
  final String? leadingIconPath;
  final String? leadingImagePath;
  final double? iconWidth;
  final Color suffixIconColor;
  final Color leadingIconColor;
  final double? iconHeight;
  final bool hasSuffixIcon;
  final bool hasLeadingIcon;
  final Color backgroundColor;
  final bool useLeadingImage;
  final Color? borderColor;
  final double borderRadius;
  final double height;
  final void Function()? onPressed;
  final bool isLoading;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _pressed = false;

  void _handleTap() {
    if (widget.isLoading || widget.onPressed == null) return;
    UiHelpers.hapticFeedback();
    widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null || widget.isLoading;
    final color = isDisabled
        ? widget.backgroundColor.withValues(alpha: 0.8)
        : (_pressed ? widget.backgroundColor.withValues(alpha: 0.85) : widget.backgroundColor);

    return GestureDetector(
      onTap: isDisabled ? null : _handleTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInOut,
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(color: widget.borderColor ?? Colors.transparent),
        ),
        child: Center(
          child: widget.isLoading
              ? const SpinKitThreeBounce(color: AppColor.white, size: 20)
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (widget.hasLeadingIcon)
                      (widget.useLeadingImage == false)
                          ? SvgPicture.asset(
                              widget.leadingIconPath ?? '',
                              width: widget.iconWidth,
                              height: widget.iconHeight,
                              colorFilter: ColorFilter.mode(widget.leadingIconColor, BlendMode.srcIn),
                            )
                          : Image.asset(
                              widget.leadingImagePath ?? Assets.images.appLogo.path,
                              width: widget.iconWidth,
                              height: widget.iconHeight,
                            ),
                    if (widget.hasLeadingIcon) const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        widget.text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: widget.textColor,
                          fontSize: widget.textSize,
                          fontWeight: widget.textFontWeight,
                        ),
                      ),
                    ),
                    if (widget.hasSuffixIcon) const SizedBox(width: 8),
                    if (widget.hasSuffixIcon)
                      SvgPicture.asset(
                        widget.sufficIconPath ?? '',
                        width: widget.iconWidth,
                        height: widget.iconHeight,
                        colorFilter: ColorFilter.mode(widget.suffixIconColor, BlendMode.srcIn),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
