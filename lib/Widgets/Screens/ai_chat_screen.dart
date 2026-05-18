import 'package:flutter/material.dart';
import 'package:june/Widgets/AI/ai_bubble.dart';
import 'package:june/Widgets/AI/chat_models.dart';
import 'package:june/Widgets/AI/input_bar.dart';
import 'package:june/Widgets/AI/typing_indicator.dart';
import 'package:june/Widgets/AI/user_bubble.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

const _kMessages = [
  ChatMessage(
    isUser: true,
    text:
        "I'm feeling a bit overwhelmed with tomorrow's list. I have three back-to-back meetings in the morning and I still need to finish the design system documentation.",
    time: '10:42 AM',
  ),
  ChatMessage(
    isUser: false,
    text:
        'I understand. Based on your energy patterns, finishing documentation requires high cognitive load which usually peaks for you between 2 PM and 4 PM.',
    time: '10:43 AM',
    proposal: ChatProposal(
      deepFocusLabel: 'Deep Focus: Documentation',
      deepFocusTime: '14:00 – 16:00',
      rescheduleLabel: 'Client Sync',
      rescheduleAction: 'Move to Wednesday',
      question:
          "Would you like me to move your 3 PM 'Client Sync' to Wednesday morning to create a 2-hour Deep Focus block tomorrow?",
    ),
  ),
  ChatMessage(
    isUser: true,
    text:
        "That sounds perfect. Let's do that. Also, can you set a reminder to take a break after those morning meetings? I usually forget to eat lunch when I'm back-to-back.",
    time: '10:45 AM',
  ),
];

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.surfaceColor,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: StretchingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: const EdgeInsets.fromLTRB(
                    MyTheme.spaceMd,
                    MyTheme.spaceMd,
                    MyTheme.spaceMd,
                    MyTheme.spaceSm,
                  ),
                  itemCount: _kMessages.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(height: MyTheme.spaceLg),
                  itemBuilder: (context, i) {
                    if (i < _kMessages.length) {
                      final msg = _kMessages[i];
                      return msg.isUser
                          ? UserBubble(message: msg)
                          : AiBubble(message: msg);
                    }
                    return const TypingIndicator();
                  },
                ),
              ),
            ),
            const InputBar(),
          ],
        ),
      ),
    );
  }
}
