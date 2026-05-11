import 'package:flutter/material.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

enum PasswordStrength { weak, medium, strong }

extension _PasswordStrengthExt on PasswordStrength {
  String get label => switch (this) {
        PasswordStrength.weak => 'Weak',
        PasswordStrength.medium => 'Medium',
        PasswordStrength.strong => 'Strong',
      };

  int get filledSegments => switch (this) {
        PasswordStrength.weak => 1,
        PasswordStrength.medium => 2,
        PasswordStrength.strong => 3,
      };
}

class PasswordStrengthBar extends StatelessWidget {
  final PasswordStrength strength;

  const PasswordStrengthBar({
    super.key,
    this.strength = PasswordStrength.strong,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 3; i++) ...[
          if (i > 0) const SizedBox(width: 6),
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: i < strength.filledSegments
                    ? MyTheme.signUpTeal
                    : MyTheme.signUpFieldBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
        const SizedBox(width: 10),
        Text(
          strength.label,
          style: const TextStyle(
            fontFamily: MyTheme.interFont,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: MyTheme.signUpTeal,
          ),
        ),
      ],
    );
  }
}
