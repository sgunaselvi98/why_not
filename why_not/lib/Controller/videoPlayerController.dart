import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:why_not/View/loginscreens/loginview.dart';
import 'package:why_not/View/videoscreen.dart';

class VideoModel extends ChangeNotifier {
  late VideoPlayerController _controller;

  VideoPlayerController get controller => _controller;
  bool navigatetoNewScreen = false;
  BuildContext? _context;

  VideoModel(ChangeNotifierProviderRef ref) {
    _context = ref.read(contextprov).getContext();
    initialize();
  }
  void initialize() {
    _controller = VideoPlayerController.asset('assets/videos/appintro.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        togglePlayPause();
        notifyListeners();
      });

    // Add listener for when the video ends
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        // After the video ends, navigate to a new screen
        navigatetoNewScreen = true;
        if (_context != null) {
          Navigator.push(
            _context!,
            MaterialPageRoute(builder: (context) => LoginView()),
          );
        }
      }
    });
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    notifyListeners();
  }
}

class contextProvider extends ChangeNotifier {
  BuildContext? context;
  BuildContext? getContext() {
    return context;
  }

  setContext(BuildContext context) {
    this.context = context;
  }
}
