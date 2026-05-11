import 'package:flutter/material.dart';

class CustomDefaultCard extends StatelessWidget {
  const CustomDefaultCard({
    super.key,
    this.child,
    this.backgroundColor,
  });

  final Widget? child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? Theme.of(context).colorScheme.surfaceContainerLowest,
      elevation: 0.7,
      shadowColor: Theme.of(context).colorScheme.primary.withAlpha(100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), 
      ),
      child: child
    ); 
  }
}