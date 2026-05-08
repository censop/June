
import 'package:flutter/material.dart';

class CustomElevatedPrimaryButton extends StatefulWidget {
  const CustomElevatedPrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final Function()? onPressed;
  final String text;


  @override
  State<CustomElevatedPrimaryButton> createState() => _CustomElevatedPrimaryButtonState();
}

class _CustomElevatedPrimaryButtonState extends State<CustomElevatedPrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16)
        ),
        backgroundColor: Theme.of(context).colorScheme.primary
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary
        ),
      )
    );
  }
}