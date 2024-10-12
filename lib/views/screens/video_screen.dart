import 'package:audioplayers/audioplayers.dart';
import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/controller/video_controller.dart';
import 'package:breath_in/models/video_model.dart';
import 'package:breath_in/views/custom_widgets/custom_icon_button.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PlayVideoScreen extends StatefulWidget {
  final VideoModel? videoModel;
  const PlayVideoScreen({super.key, required this.videoModel,
  });
  @override
  State<PlayVideoScreen> createState() => _PlayVideoWidgetState();
}

class _PlayVideoWidgetState extends State<PlayVideoScreen> {
  late  VideoController  videoControllers;

  @override
  void initState() {
    super.initState();
    videoControllers = Get.put(VideoController());
    videoControllers.videoPlayerController(widget.videoModel!.videoFile);
  }
  @override
  void dispose() {
    videoControllers.videoController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        videoControllers.backAction();
        if (videoControllers.isShowingPlay.value == true) {
          videoControllers.showingPlay();
        }
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return true;
      },
      child: Obx(() {
        return Scaffold(
          backgroundColor: ColorConstant.blackColor,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: videoControllers.isShowingPlay.value == true
                ? IconButton(
                onPressed: () {
                  Get.back();
                  videoControllers.backAction();
                  if (videoControllers.isShowingPlay.value == true) {
                    videoControllers.showingPlay();
                  }
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: ColorConstant.whiteColor,
                ))
                : Container(),
            actions: [
              videoControllers.isShowingPlay.value == true
                  ? IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: ColorConstant.whiteColor,
                  ))
                  : Container(),
            ],
          ),
          body: Center(
            child: Stack(
              children: [
                FutureBuilder(
                  future: videoControllers.initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // Automatically adjust based on aspect ratio
                      final aspectRatio = videoControllers.videoController.value.aspectRatio;

                      return GestureDetector(
                        onTap: () {
                          videoControllers.showingPlay();
                        },
                        child: ClipRRect(
                          child: AspectRatio(
                            aspectRatio: aspectRatio, // Ensure the video maintains its aspect ratio
                            child: VideoPlayer(videoControllers.videoController),
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
                // Controls at the bottom of the screen
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: videoControllers.isShowingPlay.value
                        ? Column(
                      children: [
                        // Video control buttons (play/pause, forward, etc.)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            CustomIconButton(
                              icon: Icon(Icons.skip_previous,
                                  color: ColorConstant.whiteColor, size: 30.sp),
                              onTap: (){},
                            ),

                         CustomIconButton(
                           icon: Icon(Icons.replay_10,
                               color: ColorConstant.whiteColor, size: 30.sp),
                           onTap: (){
                             final currentPosition =
                                 videoControllers.videoController.value.position;
                             final newPosition = currentPosition.inSeconds > 10
                                 ? Duration(seconds: currentPosition.inSeconds - 10)
                                 : Duration.zero;
                             videoControllers.videoController.seekTo(newPosition);
                           },
                         ),

                       CustomIconButton(
                         icon: Icon(
                           videoControllers.playerState.value == PlayerState.playing
                               ? Icons.pause
                               : Icons.play_arrow,
                           color: ColorConstant.whiteColor,
                           size: 30.sp,
                         ),
                         onTap: () {
                           videoControllers.playAndPause();
                         },

                       ),

                            CustomIconButton(
                              icon:Icon(Icons.forward_10,
                                  color: ColorConstant.whiteColor, size: 30.sp),
                              onTap: (){
                                final currentPosition =
                                    videoControllers.videoController.value.position;
                                final maxDuration =
                                    videoControllers.videoController.value.duration;
                                final newPosition = currentPosition.inSeconds + 10 <
                                    maxDuration.inSeconds
                                    ? Duration(seconds: currentPosition.inSeconds + 10)
                                    : maxDuration;
                                videoControllers.videoController.seekTo(newPosition);
                              },
                            ),

                            CustomIconButton(
                              icon:Icon(Icons.skip_next,
                                  color: ColorConstant.whiteColor, size: 30.sp),
                              onTap: (){},
                            ),

                          ],
                        ),
                       videoControllers.isLandScape.value?SizedBox(height: 70.h,):SizedBox(height: 30.h,),
                        // Video duration and fullscreen button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              "${videoControllers.formatDuration(videoControllers.position.value)} / ${videoControllers.formatDuration(videoControllers.videoController.value.duration)}",
                              fw: FontWeight.w500,
                              size: 14.sp,
                              color: Colors.white,
                            ),
                            InkWell(
                              onTap: () {
                                if (videoControllers.isLandScape.value == false) {
                                  // Switch to fullscreen (landscape mode)
                                  SystemChrome.setPreferredOrientations([
                                    DeviceOrientation.landscapeRight,
                                    DeviceOrientation.landscapeLeft,
                                  ]);
                                  videoControllers.landscapeOrPortrait();
                                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Hide status/navigation bars
                                } else {
                                  // Exit fullscreen (portrait mode)
                                  SystemChrome.setPreferredOrientations([
                                    DeviceOrientation.portraitUp,
                                    DeviceOrientation.portraitDown,
                                  ]);
                                  videoControllers.landscapeOrPortrait();
                                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // Show status/navigation bars
                                }
                              },
                              child: Icon(
                                Icons.fullscreen,
                                color: ColorConstant.whiteColor,
                              ),
                            ),
                          ],
                        ),

                        // Progress slider
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 2.h,
                            activeTrackColor: Colors.white,
                            inactiveTrackColor: Colors.grey,
                            thumbColor: Colors.white,
                          ),
                          child: Slider(
                            value: videoControllers.position.value.inSeconds.toDouble(),
                            min: 0.0,
                            max: videoControllers.videoController.value.duration.inSeconds
                                .toDouble() >
                                0
                                ? videoControllers.videoController.value.duration.inSeconds
                                .toDouble()
                                : 1.0,
                            onChanged: (value) {
                              videoControllers.sliderPosition(value);
                            },
                          ),
                        ),
                      ],
                    )
                        : Container(),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }}