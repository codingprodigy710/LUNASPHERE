import 'package:flutter/material.dart';
import '../../widgets/post_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
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
