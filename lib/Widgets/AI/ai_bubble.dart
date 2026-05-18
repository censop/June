import 'package:flutter/material.dart';
import 'package:june/Widgets/AI/bot_avatar.dart';
import 'package:june/Widgets/AI/chat_models.dart';
import 'package:june/Widgets/AI/proposal_card.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class AiBubble extends StatelessWidget {
  final ChatMessage message;
  const AiBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BotAvatar(),
        const SizedBox(width: MyTheme.spaceSm + 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                elevation: 0.7,
                shadowColor: MyTheme.primaryColor.withValues(alpha: 0.10),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(MyTheme.radiusSm),
                    topRight: Radius.circular(MyTheme.radiusLg),
                    bottomLeft: Radius.circular(MyTheme.radiusLg),
                    bottomRight: Radius.circular(MyTheme.radiusLg),
                  ),
                  side: BorderSide(
                    color: MyTheme.outlineVariantColor.withValues(alpha: 0.4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(MyTheme.spaceMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.text,
                        style: tt.bodyMedium?.copyWith(
                          color: MyTheme.primaryColor,
                          height: 1.6,
                        ),
                      ),
                      if (message.proposal != null) ...[
                        const SizedBox(height: MyTheme.spaceMd),
                        ProposalCard(proposal: message.proposal!),
                      ],
                    ],
                  ),
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
        ),
      ],
    );
  }
}
