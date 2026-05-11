import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DateSliderItem extends StatelessWidget {
  final DateTime date;
  final bool isSelected;

  const DateSliderItem({
    super.key,
    required this.date,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Colors based on your image
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color unselectedTextColor = Colors.grey.shade600;

    return Container(
      padding: EdgeInsets.all(8), 
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).colorScheme.primary.withAlpha(50) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('EEE').format(date).toUpperCase(), // MON, TUE
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? primaryColor : unselectedTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('d').format(date), // 12, 13
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? primaryColor : unselectedTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}