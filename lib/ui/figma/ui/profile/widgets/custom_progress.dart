import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_first_app/values/export.dart';

class GradientProgressBar extends StatelessWidget {
  final double percentage; // 0.0 - 1.0
  final double size; // width & height

  const GradientProgressBar({
    super.key,
    required this.percentage,
    this.size = 200, // default size
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Custom Painted Circular Progress
          CustomPaint(
            size: Size(size, size),
            painter: _GradientCircularPainter(percentage),
          ),
          // Centered Text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Personal\nprogress",
                textAlign: TextAlign.center,
                style: textFigtreeBold.copyWith(
                  fontSize: 18.spMin,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "${(percentage)}%",
                style: const TextStyle(
                  fontSize: 36,
                  color: Color(0xFF9CA5F1), // light purple
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GradientCircularPainter extends CustomPainter {
  final double percentage;

  _GradientCircularPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 16;
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width / 2) - (strokeWidth / 2);
    Rect rect = Rect.fromCircle(center: center, radius: radius);

    // Draw background circle
    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, bgPaint);

    // 👇 Gradient will start at 12 o'clock
    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: 2 * pi,
      colors: const [
        Color(0xFFB45EFF), // purple
        Color(0xFF32E0C4), // teal
        Color(0xFFB45EFF), // purple

      ],
      stops: const [0.0, 0.87, 1.0],
    );

    final gradientPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startAngle = -pi / 6; // 30° = 1 o'clock
    double sweepAngle = 2 * pi * (percentage/100);

    // 💡 Rotate canvas so gradient starts from startAngle
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(startAngle);
    canvas.translate(-center.dx, -center.dy);

    canvas.drawArc(rect, 0, sweepAngle, false, gradientPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

