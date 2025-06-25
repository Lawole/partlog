import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../common/app_colors.dart';

class CustomInputFieldPassword extends StatefulWidget {
  final String labelText;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;

  const CustomInputFieldPassword({
    Key? key,
    required this.labelText,
    this.onChanged,
    this.focusNode,
    required this.controller,
    this.validator,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  State<CustomInputFieldPassword> createState() =>
      _CustomInputFieldPasswordState();
}

class _CustomInputFieldPasswordState extends State<CustomInputFieldPassword> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !_passwordVisible,
      autovalidateMode: widget.autovalidateMode,
      style: const TextStyle(fontSize: 16),
      onChanged: widget.onChanged,
      controller: widget.controller,
      focusNode: widget.focusNode,
      cursorColor: kcPrimaryColor,
      keyboardType: TextInputType.text,
      validator: widget.validator,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(
            _passwordVisible ? Iconsax.eye : Iconsax.eye_slash,
            color: kcLightGrey,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.fromLTRB(16, 5, 5, 20),
        hintText: widget.labelText,
        hintStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: kcMediumGrey,
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: kcPrimaryColor,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: kcWhite,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(color: kcPrimaryColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: kcGray0,
          ),
        ),
        // Add error border for validation feedback
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
