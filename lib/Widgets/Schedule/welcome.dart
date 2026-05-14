import 'package:flutter/material.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MyTheme.spaceMd),
      child: RichText(
        text: TextSpan(
          style: textTheme.headlineLarge?.copyWith(
            color: MyTheme.onSurfaceColor,
          ),
          children: [
            const TextSpan(text: 'Hello, '),
            TextSpan(
              text: username,
              style: textTheme.headlineLarge?.copyWith(
                color: MyTheme.onSurfaceColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
