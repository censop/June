import 'package:flutter/material.dart';
import 'package:june/Widgets/AI/chat_models.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class ProposalCard extends StatefulWidget {
  final ChatProposal proposal;
  const ProposalCard({super.key, required this.proposal});

  @override
  State<ProposalCard> createState() => _ProposalCardState();
}

class _ProposalCardState extends State<ProposalCard> {
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
          Padding(
            padding: const EdgeInsets.fromLTRB(
              MyTheme.spaceMd,
              MyTheme.spaceSm + 4,
              MyTheme.spaceMd,
              MyTheme.spaceSm,
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_month_outlined, size: 14, color: MyTheme.signUpTeal),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MyTheme.spaceMd),
            child: Text(
              widget.proposal.question,
              style: tt.bodyMedium?.copyWith(color: MyTheme.onSurfaceColor),
            ),
          ),
          const SizedBox(height: MyTheme.spaceMd),
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
                      backgroundColor: _applied ? MyTheme.signUpTeal : MyTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(MyTheme.radiusMd),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: MyTheme.spaceSm + 2),
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
                      side: BorderSide(color: MyTheme.outlineVariantColor, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(MyTheme.radiusMd),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: MyTheme.spaceSm + 2),
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
