import 'package:flutter/material.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class ScheduleAppBar extends StatelessWidget {
  const ScheduleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(MyTheme.spaceMd, MyTheme.spaceMd, MyTheme.spaceMd, 0),
      child: Row(
        children: [
          Icon(Icons.menu_rounded, color: MyTheme.neutralColor, size: 24),
          const SizedBox(width: MyTheme.spaceSm),
          Text(
            'FocusFlow',
            style: theme.textTheme.titleLarge?.copyWith(
              color: MyTheme.signUpTeal,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          CircleAvatar(
            radius: 18,
            backgroundColor: MyTheme.signUpTeal,
            child: const Icon(Icons.person, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}
