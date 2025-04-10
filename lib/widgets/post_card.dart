import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String imageUrl;
  final String caption;

  const PostCard({
    super.key,
    required this.username,
    required this.imageUrl,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              username,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),

          // Image
          Image.network(imageUrl),

          // Caption
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              caption,
              style: const TextStyle(color: Colors.white70),
            ),
          ),

          const Divider(color: Colors.white12),
        ],
      ),
    );
  }
}
