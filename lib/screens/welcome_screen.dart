import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:lunasphere/widgets/login_page_style.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late VideoPlayerController _controller;
  bool _showUI = false;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/background.mp4")
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(false);

        Future.delayed(Duration(seconds: 5), () {
          if (mounted) {
            setState(() {
              _showUI = true;
              _opacity = 1.0;
            });
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Video
          _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : Center(child: CircularProgressIndicator()),

          // Dark overlay
          Container(color: Colors.black.withOpacity(0.4)),

          // Fade-in UI
          AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(seconds: 2),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // LUNASPHERE Title
                  Text(
                    "LUNASPHERE",
                    style: TextStyle(
                      fontFamily: "LunasphereFont",
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFE4E1),
                      letterSpacing: 5,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Sign Up Button
                  if (_showUI) ...[
                    SizedBox(
                      //width: 250,
                      child: StaticGradientBorderButton(
                        text: "Sign Up",
                        onPressed: () => Navigator.pushNamed(context, "/signup"),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],

                  // Log In Button
                  if (_showUI)
                    SizedBox(
                      //width: 250,
                      child: StaticGradientBorderButton(
                        text: "Log In",

                        onPressed: () => Navigator.pushNamed(context, "/login"),
                      ),
                    ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
