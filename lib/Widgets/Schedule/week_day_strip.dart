import 'package:flutter/material.dart';
import 'package:june/Models/day.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class WeekDayStrip extends StatefulWidget {
  final List<Day> days;
  final int selectedIndex;
  final ValueChanged<int>? onDaySelected;

  const WeekDayStrip({
    super.key,
    required this.days,
    required this.selectedIndex,
    this.onDaySelected,
  });

  @override
  State<WeekDayStrip> createState() => _WeekDayStripState();
}

class _WeekDayStripState extends State<WeekDayStrip> {
  final _controller = ScrollController();

  // Each item is 42 wide + 16 horizontal padding = 58px
  static const double _itemExtent = 58.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected());
  }

  @override
  void didUpdateWidget(WeekDayStrip old) {
    super.didUpdateWidget(old);
    if (old.selectedIndex != widget.selectedIndex) {
      _scrollToSelected();
    }
  }

  void _scrollToSelected() {
    if (!_controller.hasClients) return;
    final screenWidth = MediaQuery.of(context).size.width;
    final offset =
        (widget.selectedIndex * _itemExtent) - screenWidth / 2 + _itemExtent / 2;
    _controller.animateTo(
      offset.clamp(0.0, _controller.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      child: ListView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.days.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () => widget.onDaySelected?.call(i),
            child: SizedBox(
              width: _itemExtent,
              child: _DayItem(
                day: widget.days[i],
                isSelected: i == widget.selectedIndex,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DayItem extends StatelessWidget {
  final Day day;
  final bool isSelected;

  const _DayItem({required this.day, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isSelected ? MyTheme.signUpTeal : MyTheme.signUpSubtitle;

    return Column(
      children: [
        // Teal top indicator bar (only when selected)
        Container(
          height: 3,
          width: 24,
          decoration: BoxDecoration(
            color: isSelected ? MyTheme.signUpTeal : Colors.transparent,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(2),
              bottomRight: Radius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 42,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: isSelected
                ? Border.all(color: MyTheme.signUpTeal, width: 1.5)
                : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                day.shortName,
                style: theme.textTheme.labelSmall?.copyWith(color: color),
              ),
              const SizedBox(height: 4),
              Text(
                day.dayNumber.toString(),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
