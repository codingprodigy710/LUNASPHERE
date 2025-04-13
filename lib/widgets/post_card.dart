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
    const Color primaryColor = Color(0xFF25CFD5);
    const Color secondaryColor = Color(0xFF7228D3);
    const Color backgroundColor = Color(0xFF121212);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Profile picture + username
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Icon(Icons.more_vert, color: Colors.white54),
              ],
            ),
          ),

          // Post image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageurl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          // Caption
          if (caption.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                caption,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),

          // Timestamp
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 10),
            child: Text(
              timestamp,
              style: TextStyle(
                color: Colors.white38,
                fontSize: 12,
              ),
            ),
          ),

          const Divider(color: Colors.white10, thickness: 0.5, height: 0),
        ],
      ),
    );
  }
}
