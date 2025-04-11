import 'package:flutter/material.dart';

class StaticGradientBorderButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // <-- ADD THIS

  const StaticGradientBorderButton({
    super.key,
    required this.text,
    this.onPressed, // <-- ADD THIS
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // <-- MAKE IT TAPPABLE
      child: Container(
        width: 140,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF6F00FF), // Purple
              Color(0xFF00D8FF), // Blue
            ],
          ),
        ),
        child: Container(
          width: 138,
          height: 58,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF111215),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
