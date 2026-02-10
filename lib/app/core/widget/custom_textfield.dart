import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/app_colors.dart';
import '../style/app_style.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final VoidCallback? onSuffixIconPressed;
  final String? errorText;
  final String? helperText;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final bool readOnly;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onSuffixIconPressed,
    this.errorText,
    this.helperText,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction,
    this.onChanged,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: AppColors.inputBorder,
      end: AppColors.focusBorder,
    ).animate(_animationController);

    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  bool _isDarkContext(BuildContext context) {
    try {
      final theme = Theme.of(context);
      final scaffold = theme.scaffoldBackgroundColor;
      if (scaffold == AppColors.black || scaffold.computeLuminance() < 0.1) {
        return true;
      }
      return theme.brightness == Brightness.dark;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            final isDarkTheme = _isDarkContext(context);

            return Container(
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                color: isDarkTheme
                    ? Color(0xFF151920).withValues(alpha: 0.6)
                    : AppColors.inputBackground,
                border: Border.all(color: AppColors.primaryColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 0),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: TextFormField(
                controller: widget.controller,
                focusNode: _focusNode,
                keyboardType: widget.keyboardType,
                obscureText: widget.obscureText,
                readOnly: widget.readOnly,
                maxLines: widget.obscureText ? 1 : widget.maxLines,
                minLines: widget.minLines,
                textInputAction: widget.textInputAction,
                onChanged: widget.onChanged,
                cursorColor: AppColors.primaryColor,
                cursorHeight: 20.h,
                style: inputTextStyle(
                  color: isDarkTheme ? AppColors.white : AppColors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: widget.prefixIcon != null ? 12.w : 16.w,
                    vertical: 16.h,
                  ),
                  hintText: widget.hintText ?? widget.labelText,
                  hintStyle: inputHintStyle(
                    color: isDarkTheme
                        ? AppColors.darkTextMuted
                        : AppColors.subtleGray,
                  ),
                  labelText: widget.labelText,
                  labelStyle: inputLabelStyle(
                    color: isDarkTheme
                        ? AppColors.darkTextSecondary
                        : AppColors.subtleGray,
                  ),
                  floatingLabelStyle: inputFloatingLabelStyle(),
                  floatingLabelBehavior: widget.labelText != null
                      ? FloatingLabelBehavior.auto
                      : FloatingLabelBehavior.never,
                  prefixIcon: widget.prefixIcon != null
                      ? Padding(
                          padding: EdgeInsets.only(left: 12.w, right: 8.w),
                          child: Icon(
                            widget.prefixIcon,
                            color: AppColors.primaryColor,
                            size: 24.r,
                          ),
                        )
                      : null,
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  suffixIcon: widget.suffixIcon != null
                      ? GestureDetector(
                          onTap: widget.onSuffixIconPressed,
                          child: Padding(
                            padding: EdgeInsets.only(right: 12.w, left: 8.w),
                            child: Icon(
                              widget.suffixIcon,
                              color: AppColors.primaryColor,
                              size: 24.r,
                            ),
                          ),
                        )
                      : null,
                  suffixIconConstraints: BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorText: widget.errorText,
                  errorStyle: inputErrorStyle(),
                  helperText: widget.helperText,
                  helperStyle: inputHelperStyle(
                    color: isDarkTheme
                        ? AppColors.darkTextSecondary
                        : AppColors.subtleGray,
                  ),
                ),
              ),
            );
          },
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 4.w),
            child: Text(
              widget.errorText!,
              style: inputErrorStyle(),
            ),
          ),
      ],
    );
  }
}

Widget commonTextField({
  required String labelText,
  required IconData icon,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  VoidCallback? onSuffixIconPressed,
  IconData? suffixIcon,
}) {
  return CustomTextField(
    labelText: labelText,
    prefixIcon: icon,
    suffixIcon: suffixIcon,
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    onSuffixIconPressed: onSuffixIconPressed,
  );
}
