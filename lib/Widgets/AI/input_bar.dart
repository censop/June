import 'package:flutter/material.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class InputBar extends StatelessWidget {
  const InputBar({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        MyTheme.spaceMd,
        MyTheme.spaceSm,
        MyTheme.spaceMd,
        MyTheme.spaceMd,
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: MyTheme.spaceMd,
              right: 52,
              top: MyTheme.spaceMd,
              bottom: MyTheme.spaceMd,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MyTheme.radiusXl),
              border: Border.all(
                color: MyTheme.outlineVariantColor.withValues(alpha: 0.6),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Dump your tasks here...',
                    style: tt.bodyMedium?.copyWith(color: MyTheme.outlineColor),
                  ),
                ),
                Icon(Icons.mic_none_rounded, size: 24, color: MyTheme.outlineColor),
              ],
            ),
          ),
          Positioned(
            right: 8,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: MyTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
