import 'dart:math' as math;
import 'package:flutter/material.dart';

class RotatingMoonBackground extends StatefulWidget {
  const RotatingMoonBackground({super.key});

  @override
  _RotatingMoonBackgroundState createState() => _RotatingMoonBackgroundState();
}

class _RotatingMoonBackgroundState extends State<RotatingMoonBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _showMoon = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );

    // Delay visibility and start animation
    Future.delayed(const Duration(seconds: 8), () {
      if (mounted) {
        setState(() => _showMoon = true);
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_showMoon) return const SizedBox.shrink();

    return Positioned.fill(
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * math.pi,
              child: child,
            );
          },
          child: Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/images/moon.png',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
              color: Colors.white.withAlpha(77), // 77 ≈ 30% opacity (255 * 0.3)
              colorBlendMode: BlendMode.plus,
            ),
          ),
        ),
      ),
    );
  }
}
