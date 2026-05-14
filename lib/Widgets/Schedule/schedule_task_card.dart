import 'package:flutter/material.dart';
import 'package:june/Widgets/Schedule/edit_task_sheet.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

enum ImpactLevel { high, low }

class ScheduleTaskCard extends StatefulWidget {
  final String title;
  final String timeRange;
  final Color accentColor;
  final List<String> subtasks;
  final bool initialCompleted;
  final ImpactLevel initialImpact;

  const ScheduleTaskCard({
    super.key,
    required this.title,
    required this.timeRange,
    required this.accentColor,
    this.subtasks = const [],
    this.initialCompleted = false,
    this.initialImpact = ImpactLevel.high,
  });

  @override
  State<ScheduleTaskCard> createState() => _ScheduleTaskCardState();
}

class _ScheduleTaskCardState extends State<ScheduleTaskCard> {
  late bool _completed;
  late List<bool> _subtaskCompleted;
  late ImpactLevel _impact;

  @override
  void initState() {
    super.initState();
    _completed = widget.initialCompleted;
    _subtaskCompleted = List.filled(widget.subtasks.length, false);
    _impact = widget.initialImpact;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => showEditTaskDialog(
        context,
        title: widget.title,
        timeRange: widget.timeRange,
        subtasks: widget.subtasks,
        impact: _impact,
      ),
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: MyTheme.spaceMd),
      child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(MyTheme.radiusLg),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(135, 20, 27, 44).withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MyTheme.radiusLg),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4, color: widget.accentColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(MyTheme.spaceMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + completion checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontSize: 18,
                                    decoration: _completed
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: _completed
                                        ? MyTheme.outlineColor
                                        : MyTheme.neutralColor,
                                  ),
                                ),
                                const SizedBox(height: MyTheme.spaceXs),
                                Text(
                                  widget.timeRange,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: MyTheme.signUpSubtitle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: MyTheme.spaceSm),
                          GestureDetector(
                            onTap: () =>
                                setState(() => _completed = !_completed),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _completed
                                    ? widget.accentColor
                                    : Colors.transparent,
                                border: Border.all(
                                  color: _completed
                                      ? widget.accentColor
                                      : MyTheme.outlineVariantColor,
                                  width: 1.5,
                                ),
                              ),
                              child: _completed
                                  ? const Icon(Icons.check,
                                      size: 14, color: Colors.white)
                                  : null,
                            ),
                          ),
                        ],
                      ),

                      // Subtasks
                      if (widget.subtasks.isNotEmpty) ...[
                        const SizedBox(height: MyTheme.spaceSm),
                        for (var i = 0; i < widget.subtasks.length; i++) ...[
                          if (i > 0) const SizedBox(height: MyTheme.spaceXs),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => setState(() =>
                                    _subtaskCompleted[i] =
                                        !_subtaskCompleted[i]),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(MyTheme.radiusSm),
                                    color: _subtaskCompleted[i]
                                        ? widget.accentColor
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: _subtaskCompleted[i]
                                          ? widget.accentColor
                                          : MyTheme.outlineVariantColor,
                                      width: 1.2,
                                    ),
                                  ),
                                  child: _subtaskCompleted[i]
                                      ? const Icon(Icons.check,
                                          size: 10, color: Colors.white)
                                      : null,
                                ),
                              ),
                              const SizedBox(width: MyTheme.spaceSm),
                              Expanded(
                                child: Text(
                                  widget.subtasks[i],
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: _subtaskCompleted[i]
                                        ? MyTheme.outlineColor
                                        : MyTheme.onSurfaceVariantColor,
                                    decoration: _subtaskCompleted[i]
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],

                      // Impact dropdown
                      const SizedBox(height: MyTheme.spaceMd),
                      PopupMenuButton<ImpactLevel>(
                        initialValue: _impact,
                        onSelected: (v) => setState(() => _impact = v),
                        offset: const Offset(0, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(MyTheme.radiusMd),
                        ),
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            value: ImpactLevel.high,
                            child: _ImpactMenuRow(
                              label: 'High Impact',
                              icon: Icons.bolt_rounded,
                              color: MyTheme.primaryColor,
                            ),
                          ),
                          PopupMenuItem(
                            value: ImpactLevel.low,
                            child: _ImpactMenuRow(
                              label: 'Low Impact',
                              icon: Icons.remove_circle_outline,
                              color: MyTheme.signUpSubtitle,
                            ),
                          ),
                        ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: MyTheme.spaceSm, vertical: MyTheme.spaceXs),
                          decoration: BoxDecoration(
                            color: _impact == ImpactLevel.high
                                ? MyTheme.primaryColor.withValues(alpha: 0.08)
                                : MyTheme.surfaceContainerColor,
                            borderRadius:
                                BorderRadius.circular(MyTheme.radiusMd),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _impact == ImpactLevel.high
                                    ? Icons.bolt_rounded
                                    : Icons.remove_circle_outline,
                                size: 13,
                                color: _impact == ImpactLevel.high
                                    ? MyTheme.primaryColor
                                    : MyTheme.signUpSubtitle,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _impact == ImpactLevel.high
                                    ? 'HIGH IMPACT'
                                    : 'LOW IMPACT',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: _impact == ImpactLevel.high
                                      ? MyTheme.primaryColor
                                      : MyTheme.signUpSubtitle,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(width: MyTheme.spaceXs),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 13,
                                color: _impact == ImpactLevel.high
                                    ? MyTheme.primaryColor
                                    : MyTheme.signUpSubtitle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    ),
    );
  }
}

class _ImpactMenuRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _ImpactMenuRow({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
        ),
      ],
    );
  }
}
