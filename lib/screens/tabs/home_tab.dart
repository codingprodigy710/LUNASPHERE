import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../widgets/post_card.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final ScrollController _scrollController = ScrollController();
  final List<DocumentSnapshot> _posts = [];
  bool _isLoading = false;
  bool _hasMore = true;
  final int _documentLimit = 5;
  DocumentSnapshot? _lastDocument;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
        _fetchPosts();
      }
    });
  }

  // Function to format timestamp to a readable string
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate(); // Convert to DateTime
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime); // Format it to your desired format
  }

  // Fetch posts from Firestore
  Future<void> _fetchPosts() async {
    if (!_hasMore) return;
    setState(() => _isLoading = true);

    Query query = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .limit(_documentLimit);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    final querySnapshot = await query.get();
    final docs = querySnapshot.docs;

    if (docs.isNotEmpty) {
      _lastDocument = docs.last;
      _posts.addAll(docs);
    }

    if (docs.length < _documentLimit) {
      _hasMore = false;
    }

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _posts.isEmpty && _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        controller: _scrollController,
        itemCount: _posts.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _posts.length) {
            // Convert the timestamp to a string
            final timestamp = formatTimestamp(_posts[index]['timestamp']);

            return PostCard(
              username: _posts[index]['username'],
              imageurl: _posts[index]['imageurl'],
              caption: _posts[index]['caption'],
              profileImageUrl: _posts[index]['profileImageUrl'],
              timestamp: timestamp, // Pass the formatted timestamp
            );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
