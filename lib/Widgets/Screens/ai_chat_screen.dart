import 'package:flutter/material.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

// ── Sample conversation data ──────────────────────────────────────────────────

const _kMessages = [
  _ChatMessage(
    isUser: true,
    text:
        "I'm feeling a bit overwhelmed with tomorrow's list. I have three back-to-back meetings in the morning and I still need to finish the design system documentation.",
    time: '10:42 AM',
  ),
  _ChatMessage(
    isUser: false,
    text:
        'I understand. Based on your energy patterns, finishing documentation requires high cognitive load which usually peaks for you between 2 PM and 4 PM.',
    time: '10:43 AM',
    proposal: _Proposal(
      deepFocusLabel: 'Deep Focus: Documentation',
      deepFocusTime: '14:00 – 16:00',
      rescheduleLabel: 'Client Sync',
      rescheduleAction: 'Move to Wednesday',
      question:
          "Would you like me to move your 3 PM 'Client Sync' to Wednesday morning to create a 2-hour Deep Focus block tomorrow?",
    ),
  ),
  _ChatMessage(
    isUser: true,
    text:
        "That sounds perfect. Let's do that. Also, can you set a reminder to take a break after those morning meetings? I usually forget to eat lunch when I'm back-to-back.",
    time: '10:45 AM',
  ),
];

// ── Data classes ──────────────────────────────────────────────────────────────

class _Proposal {
  final String deepFocusLabel;
  final String deepFocusTime;
  final String rescheduleLabel;
  final String rescheduleAction;
  final String question;

  const _Proposal({
    required this.deepFocusLabel,
    required this.deepFocusTime,
    required this.rescheduleLabel,
    required this.rescheduleAction,
    required this.question,
  });
}

class _ChatMessage {
  final bool isUser;
  final String text;
  final String time;
  final _Proposal? proposal;

  const _ChatMessage({
    required this.isUser,
    required this.text,
    required this.time,
    this.proposal,
  });
}

// ── Screen ────────────────────────────────────────────────────────────────────

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.surfaceColor,
      body: SafeArea(
        child: Column(
          children: [
            _AiAppBar(),
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
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: MyTheme.spaceLg),
                  itemBuilder: (context, i) {
                    if (i < _kMessages.length) {
                      final msg = _kMessages[i];
                      return msg.isUser
                          ? _UserBubble(message: msg)
                          : _AiBubble(message: msg);
                    }
                    return const _TypingIndicator();
                  },
                ),
              ),
            ),
            _InputBar(),
          ],
        ),
      ),
    );
  }
}

// ── App bar ───────────────────────────────────────────────────────────────────

class _AiAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MyTheme.spaceMd,
        vertical: MyTheme.spaceSm + 4,
      ),
      decoration: BoxDecoration(
        color: MyTheme.surfaceContainerLowest,
        border: Border(
          bottom: BorderSide(
            color: MyTheme.outlineVariantColor.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.menu_rounded,
              size: 22, color: MyTheme.onSurfaceVariantColor),
          const SizedBox(width: MyTheme.spaceMd),
          Expanded(
            child: Text(
              'AI Assistant',
              style: tt.titleLarge?.copyWith(color: MyTheme.primaryColor),
            ),
          ),
          CircleAvatar(
            radius: 18,
            backgroundColor: MyTheme.primaryColor.withValues(alpha: 0.12),
            child: Text(
              'B',
              style: tt.labelLarge?.copyWith(
                color: MyTheme.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── User bubble ───────────────────────────────────────────────────────────────

class _UserBubble extends StatelessWidget {
  final _ChatMessage message;
  const _UserBubble({required this.message});

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
            decoration: BoxDecoration(
              color: MyTheme.surfaceContainerColor,
              borderRadius: const BorderRadius.only(
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

// ── AI bubble ─────────────────────────────────────────────────────────────────

class _AiBubble extends StatelessWidget {
  final _ChatMessage message;
  const _AiBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BotAvatar(),
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
                        _ProposalCard(proposal: message.proposal!),
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

// ── Bot avatar ────────────────────────────────────────────────────────────────

class _BotAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: MyTheme.primaryColor,
        borderRadius: BorderRadius.circular(MyTheme.radiusMd),
      ),
      child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 18),
    );
  }
}

// ── Proposal card ─────────────────────────────────────────────────────────────

class _ProposalCard extends StatefulWidget {
  final _Proposal proposal;
  const _ProposalCard({required this.proposal});

  @override
  State<_ProposalCard> createState() => _ProposalCardState();
}

class _ProposalCardState extends State<_ProposalCard> {
  bool _applied = false;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(MyTheme.radiusMd),
        border: Border.all(
          color: MyTheme.outlineVariantColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(
              MyTheme.spaceMd,
              MyTheme.spaceSm + 4,
              MyTheme.spaceMd,
              MyTheme.spaceSm,
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_month_outlined,
                    size: 14, color: MyTheme.signUpTeal),
                const SizedBox(width: MyTheme.spaceXs),
                Text(
                  'PROPOSED ADJUSTMENT',
                  style: tt.labelLarge?.copyWith(
                    color: MyTheme.signUpTeal,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          // Deep focus row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MyTheme.spaceMd),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: MyTheme.spaceSm + 4,
                vertical: MyTheme.spaceSm,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(MyTheme.radiusSm),
                border: Border(
                  left: BorderSide(color: MyTheme.signUpTeal, width: 3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.proposal.deepFocusLabel,
                      overflow: TextOverflow.ellipsis,
                      style: tt.bodyMedium?.copyWith(
                        color: MyTheme.onSurfaceColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: MyTheme.spaceXs),
                  Text(
                    widget.proposal.deepFocusTime,
                    style: tt.bodyMedium?.copyWith(
                      color: MyTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: MyTheme.spaceXs),
          // Reschedule row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MyTheme.spaceMd),
            child: Row(
              children: [
                Text(
                  'Reschedule: ',
                  style: tt.bodyMedium?.copyWith(color: MyTheme.outlineColor),
                ),
                Flexible(
                  child: Text(
                    widget.proposal.rescheduleLabel,
                    overflow: TextOverflow.ellipsis,
                    style: tt.bodyMedium?.copyWith(color: MyTheme.onSurfaceColor),
                  ),
                ),
                const SizedBox(width: MyTheme.spaceXs),
                Flexible(
                  child: Text(
                    widget.proposal.rescheduleAction,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: tt.bodyMedium?.copyWith(
                      color: MyTheme.outlineColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: MyTheme.spaceMd),
          // Question
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MyTheme.spaceMd),
            child: Text(
              widget.proposal.question,
              style: tt.bodyMedium?.copyWith(color: MyTheme.onSurfaceColor),
            ),
          ),
          const SizedBox(height: MyTheme.spaceMd),
          // Action buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(
              MyTheme.spaceMd,
              0,
              MyTheme.spaceMd,
              MyTheme.spaceMd,
            ),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () => setState(() => _applied = true),
                    style: FilledButton.styleFrom(
                      backgroundColor: _applied
                          ? MyTheme.signUpTeal
                          : MyTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(MyTheme.radiusMd),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: MyTheme.spaceSm + 2),
                    ),
                    child: Text(
                      _applied ? 'Applied' : 'Apply Schedule',
                      style: const TextStyle(
                        fontFamily: MyTheme.geistFont,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: MyTheme.spaceSm),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: MyTheme.outlineVariantColor, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(MyTheme.radiusMd),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: MyTheme.spaceSm + 2),
                    ),
                    child: Text(
                      'Keep Current',
                      style: TextStyle(
                        fontFamily: MyTheme.geistFont,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: MyTheme.onSurfaceColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Typing indicator ──────────────────────────────────────────────────────────

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _BotAvatar(),
        const SizedBox(width: MyTheme.spaceSm + 4),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: MyTheme.spaceMd,
            vertical: MyTheme.spaceSm + 4,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(MyTheme.radiusLg),
            border: Border.all(
              color: MyTheme.outlineVariantColor.withValues(alpha: 0.4),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Dot(delay: 0),
              SizedBox(width: 6),
              _Dot(delay: 200),
              SizedBox(width: 6),
              _Dot(delay: 400),
            ],
          ),
        ),
      ],
    );
  }
}

class _Dot extends StatefulWidget {
  final int delay;
  const _Dot({required this.delay});

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(
          color: MyTheme.outlineColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// ── Input bar ─────────────────────────────────────────────────────────────────

class _InputBar extends StatelessWidget {
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
                    style: tt.bodyMedium?.copyWith(
                      color: MyTheme.outlineColor,
                    ),
                  ),
                ),
                Icon(Icons.mic_none_rounded,
                    size: 24, color: MyTheme.outlineColor),
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
              child: const Icon(Icons.send_rounded,
                  color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
