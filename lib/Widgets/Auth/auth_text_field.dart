import 'package:flutter/material.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData leadingIcon;
  final bool obscureText;
  final Widget? trailing;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.leadingIcon,
    this.obscureText = false,
    this.trailing,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: MyTheme.neutralColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: MyTheme.signUpFieldBorder, width: 1.5),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
            decoration: InputDecoration(
              prefixIcon: Icon(leadingIcon, color: MyTheme.signUpSubtitle, size: 20),
              suffixIcon: trailing,
              hintText: hint,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: MyTheme.signUpSubtitle,
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
