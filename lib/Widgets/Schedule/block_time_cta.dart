import 'package:flutter/material.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class BlockTimeCta extends StatelessWidget {
  const BlockTimeCta({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: TextButton.icon(
        onPressed: () {},
        icon: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: MyTheme.signUpSubtitle, width: 1.5),
          ),
          child: Icon(Icons.add, size: 14, color: MyTheme.signUpSubtitle),
        ),
        label: Text(
          'BLOCK TIME FOR LUNCH',
          style: theme.textTheme.labelLarge?.copyWith(
            color: MyTheme.signUpSubtitle,
          ),
        ),
      ),
    );
  }
}
