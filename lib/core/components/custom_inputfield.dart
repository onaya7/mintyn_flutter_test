import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    this.controller,
    this.currentFocus,
    this.nextFocus,
    this.isPasswordField = false,
    this.hintText,
    this.labelText,
    this.prefixIconPath,
    this.action,
    this.maxlines = 1,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.fillColor,
    this.onSuffixIconTap,
  });

  final TextEditingController? controller;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final bool isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? prefixIconPath;
  final TextInputAction? action;
  final int? maxlines;
  final bool? enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final VoidCallback? onSuffixIconTap;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      maxLines: maxlines,
      textInputAction: action,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      focusNode: currentFocus,
      onTapOutside: (event) => currentFocus?.unfocus(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      obscuringCharacter: '●',
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIconPath != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SvgPicture.asset(
                  prefixIconPath!,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).inputDecorationTheme.labelStyle?.color ??
                        Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
              )
            : null,
        suffixIcon: isPasswordField
            ? Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              )
            : null,
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
