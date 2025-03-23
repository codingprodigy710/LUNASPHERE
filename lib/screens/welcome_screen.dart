import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late VideoPlayerController _controller;
  bool _showText = false;
  double _opacity = 0.0; // Opacity for fade-in effect

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/background.mp4")
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(false);

        // Detect when the video is almost done (e.g., 2 seconds before end)
        _controller.addListener(() {
          final remainingTime = _controller.value.duration - _controller.value.position;
          if (remainingTime.inSeconds <= 2 && !_showText) {
            setState(() {
              _showText = true; // Show the text
              _opacity = 1.0; // Start fade-in
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

          // Dark overlay for better visibility
          Container(color: Colors.black.withOpacity(0.4)),

          // UI Elements (Text + Buttons)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Fade-In for "LUNASPHERE"
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 2), // Smooth fade-in
                child: Text(
                  "LUNASPHERE",
                  style: TextStyle(
                    fontFamily: "GrechenFuemen", // Match font from pubspec.yaml
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 5,
                  ),
                ),
              ),

              SizedBox(height: 40),

              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/signup");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: Text("Sign Up"),
              ),

              SizedBox(height: 20),

              // Log In Button
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white, width: 2),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: Text("Log In"),
              ),
            ],
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
