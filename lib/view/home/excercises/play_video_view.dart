import 'package:fitness_app_mvvm/utils/locator/locator.dart';
import 'package:fitness_app_mvvm/utils/nav_service.dart';
import 'package:fitness_app_mvvm/view_model/excercise_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideoView extends StatefulWidget {
  const PlayVideoView({super.key});

  @override
  State<PlayVideoView> createState() => _PlayVideoViewState();
}

class _PlayVideoViewState extends State<PlayVideoView> {
  late YoutubePlayerController _controller;
  late ExcerciseViewModel excerciseViewModel;

  @override
  void initState() {
    excerciseViewModel =
        Provider.of<ExcerciseViewModel>(locator<NavService>().nav.context);
    _controller = YoutubePlayerController(
      initialVideoId: excerciseViewModel.selectedExcercise!.videoLink!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}
