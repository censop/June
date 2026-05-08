
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.title,
    this.errorText,
    this.validator,
    this.suffixWidget,
    this.obscureText = false,
    this.editable = true,
    this.onChanged,
    this.prefixWidget,
  });

  final TextEditingController? controller;
  final String? title;
  final String? errorText;
  final String? Function(String?)? validator;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final bool obscureText;
  final bool editable;
  final ValueChanged<String>? onChanged;
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        errorText: errorText,
        hintText: title,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(100),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixWidget,
        prefixIcon: prefixWidget,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      obscureText: obscureText,
      validator: validator,
      enabled: editable,
    );
  }
}