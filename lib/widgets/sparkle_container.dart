import 'dart:math';
import 'package:flutter/material.dart';
import 'sparkle_widget.dart';

class SparkleContainer extends StatelessWidget {
  final Widget child;
  final int sparkleCount;

  const SparkleContainer({
    Key? key,
    required this.child,
    this.sparkleCount = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        ...List.generate(sparkleCount, (index) {
          final random = Random();
          return Positioned(
            left: random.nextDouble() * 300,
            top: random.nextDouble() * 300,
            child: SparkleWidget(
              color: Colors.white.withOpacity(0.8),
              size: 4 + random.nextDouble() * 8,
            ),
          );
        }),
      ],
    );
  }
}