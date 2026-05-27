import 'package:app_flutter_riverpod/app/features/catalog_movies/data/models/movie.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class PlayerService extends Notifier<void> {
  final ValueNotifier<bool> isPlaying = ValueNotifier(false);
  final ValueNotifier<YoutubeMetaData?> currentMetaData = ValueNotifier<YoutubeMetaData?>(null);
  final ValueNotifier<MovieModel?> currentMedia = ValueNotifier<MovieModel?>(null);

  final ValueNotifier<bool> repeat = ValueNotifier(false);
  final ValueNotifier<bool> aleatory = ValueNotifier(false);

  @override
  void build() {
   
  }

  void playPause() => isPlaying.value = !isPlaying.value;

  void stop() => isPlaying.value = false;

  void backAndStop(BuildContext context) {
    if (isPlaying.value) {
      isPlaying.value = false;
    } else {
      Navigator.pop(context);
    }
  }

  void setPortrait() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void setLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
}

final playerServiceProvider = NotifierProvider<PlayerService, void>(() {
  return PlayerService();
});