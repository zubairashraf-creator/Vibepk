import 'package:flutter/material.dart';

class VideoFeedClean extends StatefulWidget {
  const VideoFeedClean({super.key});

  @override
  State<VideoFeedClean> createState() => _VideoFeedCleanState();
}

class _VideoFeedCleanState extends State<VideoFeedClean> {
  bool liked = false;
  bool saved = false;
  bool following = false;
  int likes = 12500;

  void likeVibe() {
    setState(() {
      if (!liked) {
        liked = true;
        likes++;
      }
    });
  }

  void toggleLike() {
    setState(() {
      liked = !liked;
      likes += liked ? 1 : -1;
    });
  }

  void toggleSave() {
    setState(() {
      saved = !saved;
    });
  }

  void toggleFollow() {
    setState(() {
      following = !following;
    });
  }

  void showComments() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF151515),
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Be the first to comment',
                      style: TextStyle(color: Colors.white60),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      filled: true,
                      fillColor: Colors.white10,
                      suffixIcon: const Icon(Icons.send),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void shareVibe() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF151515),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Share Vibe',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text('Copy Link'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.send),
                title: const Text('Send Vibe'),
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onDoubleTap: likeVibe,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF300052),
                    Color(0xFF050505),
                    Color(0xFF002B55),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 95,
                  color: Colors.white70,
                ),
              ),
            ),
            const Positioned(
              top: 55,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'For You',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 30),
                  Text(
                    'Following',
                    style: TextStyle(color: Colors.white54),
                  ),
                  SizedBox(width: 30),
                  Text(
                    'Community',
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 12,
              bottom: 105,
              child: Column(
                children: [
                  ActionButton(
                    icon: liked
                        ? Icons.favorite
                        : Icons.favorite_border,
                    text: '$likes',
                    active: liked,
                    onTap: toggleLike,
                  ),
                  const SizedBox(height: 18),
                  ActionButton(
                    icon: Icons.comment,
                    text: '245',
                    onTap: showComments,
                  ),
                  const SizedBox(height: 18),
                  ActionButton(
                    icon: saved
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    text: saved ? 'Saved' : 'Save',
                    active: saved,
                    onTap: toggleSave,
                  ),
                  const SizedBox(height: 18),
                  ActionButton(
                    icon: Icons.share,
                    text: 'Share',
                    onTap: shareVibe,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 18,
              right: 85,
              bottom: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.deepPurple,
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        '@vibepk_official',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: toggleFollow,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            following ? 'Following' : 'Follow +',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Welcome to VibePK 🇵🇰 Create. Share. Go Viral.',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '♫ Original Sound • VibePK',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool active;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: active ? Colors.redAccent : Colors.white,
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
