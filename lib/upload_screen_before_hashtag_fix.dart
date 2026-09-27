import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'vibe_post.dart';
import 'vibe_post_store.dart';

class UploadScreen extends StatefulWidget {
  final VoidCallback? onPosted;

  const UploadScreen({super.key, this.onPosted});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _captionController = TextEditingController();

  XFile? _selectedVideo;
  VideoPlayerController? _videoController;
  bool _isLoading = false;

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.gallery,
    );

    if (video == null) return;

    setState(() {
      _isLoading = true;
      _selectedVideo = video;
    });

    await _videoController?.dispose();

    final controller = VideoPlayerController.file(
      File(video.path),
    );

    await controller.initialize();

    controller
      ..setLooping(true)
      ..play();

    if (!mounted) return;

    setState(() {
      _videoController = controller;
      _isLoading = false;
    });
  }

  void _postVibe() {
    if (_selectedVideo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose a video first'),
        ),
      );
      return;
    }

    VibePostStore.instance.addPost(
      VibePost(
        username: '@vibepk_user',
        videoPath: _selectedVideo!.path,
        caption: _captionController.text.trim(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your Vibe is ready to post!'),
        backgroundColor: Colors.purple,
      ),
    );

    widget.onPosted?.call();
  }

  @override
  void dispose() {
    _captionController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Create Vibe'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Share your creativity with Pakistan',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),

              if (_videoController != null &&
                  _videoController!.value.isInitialized)
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: AspectRatio(
                    aspectRatio: _videoController!.value.aspectRatio,
                    child: VideoPlayer(_videoController!),
                  ),
                )
              else
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.deepPurple,
                        Colors.black,
                        Colors.blue,
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.video_library,
                      color: Colors.white70,
                      size: 70,
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _pickVideo,
                  icon: const Icon(Icons.video_library),
                  label: Text(
                    _selectedVideo == null
                        ? 'Choose a video'
                        : 'Change video',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Caption',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: _captionController,
                maxLength: 150,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'What is your vibe today?',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Add Hashtags',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                children: const [
                  Chip(label: Text('#Pakistan')),
                  Chip(label: Text('#VibePK')),
                  Chip(label: Text('#Trending')),
                  Chip(label: Text('#Funny')),
                  Chip(label: Text('#Music')),
                ],
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _postVibe,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: const Text(
                    'POST VIBE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
