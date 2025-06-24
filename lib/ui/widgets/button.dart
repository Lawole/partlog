import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/text_styles.dart';

class ButtonHot extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final double? elevation;
  final Color? color;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? borderWidth;
  final Color? borderColor;
  final double? borderRadius;
  bool isDisabled = false;

  ButtonHot({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.isDisabled,
    this.color,
    this.textColor,
    this.height,
    this.width,
    this.elevation,
    this.fontWeight,
    this.borderWidth,
    this.borderColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<ButtonHot> createState() => _ButtonHotState();
}

class _ButtonHotState extends State<ButtonHot> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height ?? 52,
      child: OutlinedButton(
        onPressed: !widget.isDisabled ? widget.onPressed : null,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor:
          widget.color ?? (widget.isDisabled ? kcPrimaryColorLight : kcPrimaryColor),
          foregroundColor: widget.textColor ?? kcWhite,
          elevation: widget.elevation ?? 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 25.0),
          ),
          side: BorderSide(
            color: widget.borderColor ??
                Colors
                    .transparent,
            width: widget.borderWidth ??
                0.0,
          ),
        ),
        child: Text(
          widget.label,
          style: ktBodySemiBoldSize14.copyWith(
              color: widget.textColor ?? kcWhite,
              letterSpacing: 0.5,
              fontWeight: widget.fontWeight ?? FontWeight.w500,
              fontFamily: 'MADE TOMMY'),
        ),
      ),
    );
  }
}
