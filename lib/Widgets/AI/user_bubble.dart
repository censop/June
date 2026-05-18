import 'package:flutter/material.dart';
import 'package:june/Widgets/AI/chat_models.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class UserBubble extends StatelessWidget {
  final ChatMessage message;
  const UserBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: MyTheme.spaceMd,
              vertical: MyTheme.spaceSm + 4,
            ),
            decoration: const BoxDecoration(
              color: MyTheme.surfaceContainerColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(MyTheme.radiusLg),
                topRight: Radius.circular(MyTheme.radiusLg),
                bottomLeft: Radius.circular(MyTheme.radiusLg),
                bottomRight: Radius.circular(MyTheme.radiusSm),
              ),
            ),
            child: Text(
              message.text,
              style: tt.bodyMedium?.copyWith(color: MyTheme.onSurfaceColor),
            ),
          ),
          const SizedBox(height: MyTheme.spaceXs),
          Text(
            message.time,
            style: tt.labelMedium?.copyWith(
              color: MyTheme.outlineColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
