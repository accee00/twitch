import 'package:flutter/material.dart';
import 'package:twitch/utils/colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.obscuringCharacter = '*',
  });
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String obscuringCharacter;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 15,
      ),
      obscureText: obscureText,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: buttonColor,
            width: 2,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: secondaryBackgroundColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
