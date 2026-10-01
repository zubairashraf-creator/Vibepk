import 'package:flutter/material.dart';

class VideoFeed extends StatefulWidget {
  const VideoFeed({super.key});

  @override
  State<VideoFeed> createState() => _VideoFeedState();
}

class _VideoFeedState extends State<VideoFeed> {
  final PageController _pageController = PageController();

  final List<Map<String, String>> videos = [
    {
      'user': '@vibepk_official',
      'caption': 'Welcome to VibePK 🇵🇰 Create. Share. Go Viral.',
      'sound': 'Original Sound • VibePK',
    },
    {
      'user': '@pakistan_creator',
      'caption': 'Your creativity. Your Vibe. Your Pakistan.',
      'sound': 'Original Sound',
    },
    {
      'user': '@vibepk_creator',
      'caption': 'Share your best moments with Pakistan ❤️',
      'sound': 'VibePK Original',
    },
  ];

  bool liked = false;
  bool saved = false;
  bool following = false;
  int likes = 12500;
  int comments = 245;

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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(saved ? 'Vibe saved 🔖' : 'Vibe removed from Saved'),
        duration: const Duration(milliseconds: 900),
      ),
    );
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
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: Column(
            children: [
              const SizedBox(height: 14),
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                '$comments Comments',
                style: const TextStyle(
                  fontSize: 18,
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
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 12,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    filled: true,
                    fillColor: Colors.white10,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {},
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
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
          child: Wrap(
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
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];

          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF100020),
                      Colors.black,
                      Color(0xFF00152B),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.play_circle_fill_rounded,
                    size: 95,
                    color: Colors.white70,
                  ),
                ),
              ),

              Positioned(
                top: 55,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'For You',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
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
                    GestureDetector(
                      onTap: toggleLike,
                      onDoubleTap: toggleLike,
                      child: _ActionButton(
                        icon: liked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        text: '$likes',
                        active: liked,
                      ),
                    ),
                    const SizedBox(height: 18),
                    GestureDetector(
                      onTap: showComments,
                      child: _ActionButton(
                        icon: Icons.comment,
                        text: '$comments',
                      ),
                    ),
                    const SizedBox(height: 18),
                    GestureDetector(
                      onTap: toggleSave,
                      child: _ActionButton(
                        icon: saved
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        text: saved ? 'Saved' : 'Save',
                        active: saved,
                      ),
                    ),
                    const SizedBox(height: 18),
                    GestureDetector(
                      onTap: shareVibe,
                      child: const _ActionButton(
                        icon: Icons.share,
                        text: 'Share',
                      ),
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
                        Text(
                          video['user']!,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: toggleFollow,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
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
                    Text(
                      video['caption']!,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        const Icon(Icons.music_note, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          video['sound']!,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool active;

  const _ActionButton({
    required this.icon,
    required this.text,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
