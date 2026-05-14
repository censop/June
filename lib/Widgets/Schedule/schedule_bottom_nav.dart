import 'package:flutter/material.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class ScheduleBottomNav extends StatelessWidget {
  final int activeIndex;

  const ScheduleBottomNav({super.key, required this.activeIndex});

  static const _items = [
    (Icons.grid_view_rounded, 'Dashboard'),
    (Icons.timer_outlined, 'Focus'),
    (Icons.checklist_rounded, 'Tasks'),
    (Icons.calendar_today_outlined, 'Schedule'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: MyTheme.neutralColor.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_items.length, (i) {
          final isActive = i == activeIndex;
          final color =
              isActive ? MyTheme.signUpTeal : MyTheme.signUpSubtitle;
          return Expanded(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_items[i].$1, size: 22, color: color),
                      const SizedBox(height: 4),
                      Text(
                        _items[i].$2,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: color,
                          fontWeight: isActive
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Active left-edge indicator
                if (isActive)
                  Positioned(
                    left: 0,
                    top: 16,
                    bottom: 16,
                    child: Container(
                      width: 3,
                      decoration: BoxDecoration(
                        color: MyTheme.signUpTeal,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
