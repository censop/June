import 'package:flutter/material.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class ScheduleAssistantSheet extends StatefulWidget {
  const ScheduleAssistantSheet({super.key});

  @override
  State<ScheduleAssistantSheet> createState() => _ScheduleAssistantSheetState();
}

class _ScheduleAssistantSheetState extends State<ScheduleAssistantSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MyTheme.radiusXl),
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: MyTheme.spaceMd,
        vertical: MyTheme.spaceXl,
      ),
      child: Padding(
        padding: const EdgeInsets.all(MyTheme.spaceMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AssistantHeader(onClose: () => Navigator.of(context).pop()),
            const SizedBox(height: MyTheme.spaceMd),
            _ChatBubble(theme: theme),
            const SizedBox(height: MyTheme.spaceXs),
            Text(
              'AI Assistant · Just now',
              style: theme.textTheme.labelMedium?.copyWith(
                color: MyTheme.onSurfaceVariantColor,
              ),
            ),
            const SizedBox(height: MyTheme.spaceMd),
            Text(
              'QUICK ACTIONS',
              style: theme.textTheme.labelLarge?.copyWith(
                color: MyTheme.onSurfaceVariantColor,
              ),
            ),
            const SizedBox(height: MyTheme.spaceSm),
            const _QuickActions(),
            const SizedBox(height: MyTheme.spaceMd),
            _InputRow(controller: _controller),
          ],
        ),
      ),
    );
  }
}

class _AssistantHeader extends StatelessWidget {
  final VoidCallback onClose;
  const _AssistantHeader({required this.onClose});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: MyTheme.scheduleFab,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.auto_fix_high_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(width: MyTheme.spaceSm),
        Expanded(
          child: Text(
            'Schedule Assistant',
            style: theme.textTheme.titleLarge,
          ),
        ),
        GestureDetector(
          onTap: onClose,
          child: const Icon(
            Icons.close_rounded,
            size: 20,
            color: MyTheme.onSurfaceVariantColor,
          ),
        ),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ThemeData theme;
  const _ChatBubble({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MyTheme.spaceMd,
        vertical: MyTheme.spaceMd,
      ),
      decoration: const BoxDecoration(
        color: MyTheme.surfaceContainerLow,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MyTheme.radiusLg),
          topRight: Radius.circular(MyTheme.radiusLg),
          bottomRight: Radius.circular(MyTheme.radiusLg),
          bottomLeft: Radius.circular(MyTheme.radiusSm),
        ),
      ),
      child: Text(
        "Hi there, what's wrong?",
        style: theme.textTheme.titleMedium,
      ),
    );
  }
}

const _kQuickActions = [
  'Push schedule 30m',
  'Skip next meeting',
  'Clear afternoon',
];

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: MyTheme.spaceSm,
      runSpacing: MyTheme.spaceSm,
      children: _kQuickActions
          .map((label) => _QuickChip(label: label, theme: theme))
          .toList(),
    );
  }
}

class _QuickChip extends StatelessWidget {
  final String label;
  final ThemeData theme;
  const _QuickChip({required this.label, required this.theme});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: MyTheme.spaceMd,
          vertical: MyTheme.spaceSm,
        ),
        decoration: BoxDecoration(
          color: MyTheme.surfaceContainerLow,
          border: Border.all(
            color: MyTheme.primaryColor.withAlpha(80),
          ),
          borderRadius: BorderRadius.circular(MyTheme.radiusFull),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: MyTheme.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _InputRow extends StatelessWidget {
  final TextEditingController controller;
  const _InputRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(
        left: MyTheme.spaceMd,
        right: MyTheme.spaceXs,
        top: MyTheme.spaceXs,
        bottom: MyTheme.spaceXs,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: MyTheme.outlineVariantColor),
        borderRadius: BorderRadius.circular(MyTheme.radiusXl),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Type your request...',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: MyTheme.onSurfaceVariantColor,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: MyTheme.spaceSm,
                ),
              ),
            ),
          ),
          const SizedBox(width: MyTheme.spaceSm),
          Icon(
            Icons.mic_none_rounded,
            color: MyTheme.primaryColor,
            size: 22,
          ),
          const SizedBox(width: MyTheme.spaceSm),
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: MyTheme.scheduleFab,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
