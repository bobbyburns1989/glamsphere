
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/services.dart';
import 'sparkle_widget.dart';

class GlamSphereWidget extends StatefulWidget {
  final Function(String) onResponseGenerated;

  const GlamSphereWidget({super.key, required this.onResponseGenerated});

  @override
  State<GlamSphereWidget> createState() => _GlamSphereWidgetState();
}

class _GlamSphereWidgetState extends State<GlamSphereWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isShaking = false;
  double glowIntensity = 2.0;
  double rotation = 0.0;
  bool isHovered = false;
  String currentText = '';

  final List<String> sassyResponses = const [
    "Honey, it's a YES! 💅",
    "Not today, sweetie 💁‍♀️",
    "Ask me when Mercury isn't retrograde ✨",
    "Yaaas queen! 👑",
    "Girl, please... NO 🙄",
    "It's giving... maybe? 💫",
    "Absolutely fabulous! ✨",
    "Hi Meghan you are so cute!!! Can we snuggle?✨✨✨✨",
    "Don't even think about it 🙅‍♀️",
  ];

  List<Widget> _buildSparkles() {
    return List.generate(12, (index) {
      final random = Random();
      final angle = (index / 12) * 2 * pi;
      final radius = 170.0;

      return Positioned(
        left: 150 + radius * cos(angle),
        top: 150 + radius * sin(angle),
        child: SparkleWidget(
          color: random.nextBool() ? Colors.pink[100]! : Colors.purple[100]!,
          size: 8 + random.nextDouble() * 8,
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15), // Slow down rotation for better effect
      vsync: this,
    )..repeat();

    try {
      accelerometerEvents.listen((event) {
        if (event.x.abs() > 15 || event.y.abs() > 15 || event.z.abs() > 15) {
          if (!isShaking) {
            _handleShake();
          }
        }
      });
    } catch (e) {
      // Accelerometer not available
    }
  }

  void _handleShake() {
    if (isShaking) return;

    setState(() {
      isShaking = true;
      glowIntensity = 8.0;
      rotation = Random().nextDouble() * 2 * pi;
      currentText = sassyResponses[Random().nextInt(sassyResponses.length)];
    });

    widget.onResponseGenerated(currentText);

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isShaking = false;
        glowIntensity = 2.0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (_, event) {
        if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
          _handleShake();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: GestureDetector(
          onTap: _handleShake,
          child: SizedBox(
            width: 400,
            height: 400,
            child: Stack(
              children: [
                ..._buildSparkles(),
                Center(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _controller.value * 2 * pi + rotation,
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const SweepGradient(
                              colors: [Colors.pink, Colors.purple, Colors.deepPurple, Colors.pink],
                              stops: [0.0, 0.33, 0.66, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pink.withOpacity(0.6),
                                spreadRadius: isHovered ? glowIntensity + 2 : glowIntensity,
                                blurRadius: 25, // Enhanced glow effect
                                offset: const Offset(0, 0),
                              ),
                              BoxShadow(
                                color: Colors.purple.withOpacity(0.6),
                                spreadRadius: isHovered ? glowIntensity + 2 : glowIntensity,
                                blurRadius: 25,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              width: 240,
                              height: 240,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(0xFFFF69B4), Color(0xFF9370DB)],
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    child: Text(
                                      currentText,
                                      key: ValueKey<String>(currentText),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black26,
                                            blurRadius: 4,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
