import 'package:flutter/material.dart';
import '../../widgets/post_card.dart';
import '../inbox_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Lunasphere',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.message_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InboxScreen()),
              );
            },
          ),
        ],
      ),

      body: ListView(
        children: const [
          PostCard(
            username: 'moonwalker42',
            imageUrl: 'https://placekitten.com/400/300',
            caption: 'Just landed on Mars. 😎',
          ),
          PostCard(
            username: 'galactic_girl',
            imageUrl: 'https://placekitten.com/401/300',
            caption: 'Nebula selfie 🌌✨',
          ),
          PostCard(
            username: 'astrobot',
            imageUrl: 'https://placekitten.com/402/300',
            caption: 'Drifting through space like 🛰️',
          ),
        ],
      ),
    );
  }
}
