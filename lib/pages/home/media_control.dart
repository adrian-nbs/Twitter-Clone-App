import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../assets/twitter_icons.dart';

class ControlsOverlay extends StatelessWidget {
  const ControlsOverlay({Key? key, required this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    String seconds = controller.value.duration.inSeconds.toString();
    if (controller.value.duration.inSeconds < 10) {
      seconds = '0${controller.value.duration.inSeconds}';
    }
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(45),
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      width: 50,
                      height: 50,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Icon(
                          TwitterIcons.play,
                          color: Colors.white,
                          size: 28.0,
                          semanticLabel: 'Play',
                        ),
                      ),
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 21,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${controller.value.duration.inMinutes}:$seconds',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
