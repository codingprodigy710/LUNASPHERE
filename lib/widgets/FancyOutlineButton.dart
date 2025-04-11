import 'package:flutter/material.dart';

class FancyOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const FancyOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFFD4EDF9);
    const breakHeight = 5.0;
    const buttonWidth = 250.0;
    const buttonHeight = 50.0;

    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          // Black Background
          Container(
            width: buttonWidth,
            height: buttonHeight,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          // Pink Shine Overlay (on top of black background)
          Container(
            width: buttonWidth,
            height: buttonHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFF4081).withOpacity(0.05), // lightest pink
                  Color(0xFFFF4081).withOpacity(0.25),
                  Color(0xFFFF4081).withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          // Text
          SizedBox(
            width: buttonWidth,
            height: buttonHeight,
            child: Center(
              child: Text(
                text.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Left border - top segment
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 2,
              height: (buttonHeight - breakHeight) / 2,
              color: borderColor,
            ),
          ),
          // Left border - bottom segment
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 2,
              height: (buttonHeight - breakHeight) / 2,
              color: borderColor,
            ),
          ),

          // Right border - top segment
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 2,
              height: (buttonHeight - breakHeight) / 2,
              color: borderColor,
            ),
          ),
          // Right border - bottom segment
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 2,
              height: (buttonHeight - breakHeight) / 2,
              color: borderColor,
            ),
          ),

          // Top border
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(height: 2, color: borderColor),
          ),
          // Bottom border
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(height: 2, color: borderColor),
          ),
        ],
      ),
    );
  }
}
