import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:riverpod/riverpod.dart';
import 'package:why_not/Controller/videoPlayerController.dart';

final videoModelProvider = ChangeNotifierProvider<VideoModel>((ref) {
  return VideoModel(ref);
});
final contextprov = ChangeNotifierProvider<contextProvider>((ref) {
  return contextProvider();
});

class VideoScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(contextprov).setContext(context);
    final videoModel = ref.watch(videoModelProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: videoModel.controller != null &&
                    videoModel.controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: videoModel.controller.value.aspectRatio,
                    child: VideoPlayer(videoModel.controller),
                  )
                : CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
