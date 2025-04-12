import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String imageurl;
  final String caption;
  final String profileImageUrl;
  final String timestamp;

  const PostCard({
    super.key,
    required this.username,
    required this.imageurl,
    required this.caption,
    required this.profileImageUrl,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username and Profile Image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                  radius: 20,
                ),
                SizedBox(width: 8),
                Text(
                  username,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Image
          Image.network(imageurl),

          // Caption
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              caption,
              style: const TextStyle(color: Colors.white70),
            ),
          ),

          // Timestamp
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              timestamp,
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ),

          const Divider(color: Colors.white12),
        ],
      ),
    );
  }
}
