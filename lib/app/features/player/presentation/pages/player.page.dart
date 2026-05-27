import 'package:app_flutter_riverpod/app/core/design_system/colors/colors.dart';
import 'package:app_flutter_riverpod/app/features/catalog_movies/data/models/movie.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerPage extends ConsumerStatefulWidget {
  final MovieModel data;

  const PlayerPage({super.key, required this.data});

  @override
  ConsumerState<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    
    final videoId = YoutubePlayer.convertUrlToId(widget.data.urlMovie) ?? '';

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
        enableCaption: false,
      ),
    )..addListener(_videoListener);
    _setLandscape();
  }

  void _videoListener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      // Caso o usuário saia do modo FullScreen pelo botão do player, mantém sincronizado
    }
  }
  void _setLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  void _setPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    _setPortrait();
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        _setPortrait();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: AppColor.primary,
            progressColors: const ProgressBarColors(
              playedColor: AppColor.primary,
              handleColor: AppColor.primary,
            ),
            onReady: () {
              _isPlayerReady = true;
            },
            onEnded: (data) {
              _setPortrait();
              Navigator.pop(context);
            },
          ),
          builder: (context, player) {
            return Center(
              child: player,
            );
          },
        ),
      ),
    );
  }
}