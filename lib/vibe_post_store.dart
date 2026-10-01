import 'package:flutter/foundation.dart';
import 'vibe_post.dart';

class VibePostStore extends ChangeNotifier {
  static final VibePostStore instance = VibePostStore._();

  VibePostStore._();

  final List<VibePost> posts = [];

  void addPost(VibePost post) {
    posts.add(post);
    notifyListeners();
  }
}
