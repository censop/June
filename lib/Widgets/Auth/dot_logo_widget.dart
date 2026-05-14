import 'package:flutter/material.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class DotLogoWidget extends StatelessWidget {
  const DotLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 46,
      child: CustomPaint(painter: _DotLogoPainter()),
    );
  }
}

class _DotLogoPainter extends CustomPainter {
  // Opacity grid: 5 rows × 6 cols, fading toward edges
  static const List<List<double>> _grid = [
    [0.0, 0.0, 0.25, 0.50, 0.25, 0.0],
    [0.0, 0.40, 0.70, 0.90, 0.70, 0.35],
    [0.25, 0.70, 1.00, 1.00, 1.00, 0.65],
    [0.0, 0.40, 0.70, 0.90, 0.70, 0.35],
    [0.0, 0.0, 0.25, 0.50, 0.25, 0.0],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    const int rows = 5;
    const int cols = 6;
    final double xStep = size.width / cols;
    final double yStep = size.height / rows;
    final double dotRadius = xStep * 0.18;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final double opacity = _grid[r][c];
        if (opacity == 0.0) continue;
        canvas.drawCircle(
          Offset(xStep * c + xStep / 2, yStep * r + yStep / 2),
          dotRadius,
          Paint()
            ..color = MyTheme.signUpTeal.withValues(alpha: opacity)
            ..style = PaintingStyle.fill,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_DotLogoPainter oldDelegate) => false;
}
