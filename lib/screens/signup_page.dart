import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lunasphere/screens/main_screen.dart';
import 'package:lunasphere/widgets/login_page_style.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController(); // Username controller
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _errorMessage = '';

  Future<void> _signUp() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Validate username
    if (username.isEmpty || username.length < 3 || username.contains(' ')) {
      setState(() {
        _errorMessage = "Invalid username. Use at least 3 characters with no spaces.";
      });
      return;
    }

    // Validate email format (basic check)
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      setState(() {
        _errorMessage = "Invalid email format.";
      });
      return;
    }

    // Check if password is strong enough
    if (password.length < 6) {
      setState(() {
        _errorMessage = "Password should be at least 6 characters long.";
      });
      return;
    }

    try {
      // Create user in Firebase Authentication
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if username is already taken (Firebase Firestore query)
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _errorMessage = "Username is already taken.";
        });
        return;
      }

      // Save the username and other user details in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'email': email,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Successfully Signed Up!", style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xFFAF4C99),
          duration: Duration(seconds: 2),
        ),
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Logo
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                "assets/images/lunasphere_logo.jpeg",
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // SignUp Form
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LUNASPHERE",
                  style: TextStyle(
                    fontFamily: "LunasphereFont",
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),

                // Username Field
                _buildTextField(_usernameController, "Username", Icons.person),

                // Email Field
                _buildTextField(_emailController, "Email", Icons.email),

                // Password Field
                _buildTextField(_passwordController, "Password", Icons.lock, isPassword: true),
                SizedBox(height: 10),

                // Display error message if any
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(_errorMessage, style: TextStyle(color: Color(0xFF215CF3), fontSize: 14)),
                  ),

                SizedBox(height: 20),

                // Sign Up Button
                StaticGradientBorderButton(
                  text: "Sign Up",
                  onPressed: _signUp,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable TextField Builder
  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        cursorColor: Colors.deepPurpleAccent, // Cursor color
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.black54),
          prefixIcon: Icon(icon, color: Colors.black),
          filled: true,
          fillColor: Color(0xFF444444).withOpacity(0.7),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF444444).withOpacity(0.7), width: 1),
          ),
        ),
      ),
    );
  }
}
