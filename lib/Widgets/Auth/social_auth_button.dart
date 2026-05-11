import 'package:flutter/material.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class SocialAuthButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback? onTap;

  const SocialAuthButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyTheme.signUpFieldBorder, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontFamily: MyTheme.interFont,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: MyTheme.neutralColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
