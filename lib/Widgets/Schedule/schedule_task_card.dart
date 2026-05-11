import 'package:flutter/material.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class ScheduleTaskCard extends StatelessWidget {
  final String title;
  final String timeRange;
  final Color accentColor;
  final String? description;
  final String? badge;
  final Color? badgeColor;
  final Color? cardBg;
  final String? status;
  final Color? statusColor;
  final String? timeChip;
  final IconData? icon;
  final bool showDot;

  const ScheduleTaskCard({
    super.key,
    required this.title,
    required this.timeRange,
    required this.accentColor,
    this.description,
    this.badge,
    this.badgeColor,
    this.cardBg,
    this.status,
    this.statusColor,
    this.timeChip,
    this.icon,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cardBg ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: MyTheme.neutralColor.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left accent bar
              Container(width: 4, color: accentColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildContent(theme)),
                      const SizedBox(width: 12),
                      _buildTimeColumn(theme),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (badge != null) ...[
          Row(
            children: [
              Icon(Icons.timer_outlined,
                  size: 13, color: badgeColor ?? accentColor),
              const SizedBox(width: 4),
              Text(
                badge!,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: badgeColor ?? accentColor,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(fontSize: 17),
        ),
        if (description != null) ...[
          const SizedBox(height: 6),
          Text(
            description!,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: MyTheme.signUpSubtitle),
          ),
        ],
        if (status != null) ...[
          const SizedBox(height: 6),
          Text(
            status!,
            style: theme.textTheme.labelMedium?.copyWith(
              color: statusColor ?? MyTheme.signUpSubtitle,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTimeColumn(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (showDot)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        Text(
          timeRange,
          style: theme.textTheme.labelMedium?.copyWith(
            color: MyTheme.signUpSubtitle,
          ),
          textAlign: TextAlign.end,
        ),
        if (timeChip != null) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: MyTheme.signUpTeal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              timeChip!,
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class SmallIconBox extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;

  const SmallIconBox({
    super.key,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 18, color: iconColor),
    );
  }
}
