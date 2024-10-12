import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
class VideoController extends GetxController{


  Uint8List? thumbnailData;
  void  generateThumbnail(videoUrl){
    thumbNail(videoUrl).then((data) {
      thumbnailData = data;
      update();
    });
  }

  Future<Uint8List?> thumbNail(String videoUrl) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.PNG,
      maxWidth: 128, // Specify the width of the thumbnail
      quality: 25,    // Specify the quality of the thumbnail
    );
    return uint8list;
  }



  Rx<bool> isShowingPlay=false.obs;
  Rx<bool> isLandScape=false.obs;

  void landscapeOrPortrait(){
     isLandScape.value=!isLandScape.value;
    }

  void showingPlay(){
    isShowingPlay.value=!isShowingPlay.value;
  }


  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayerFuture;

  // Reactive variables
  Rx<PlayerState> playerState = PlayerState.stopped.obs;
  Rx<Duration> position = Duration.zero.obs;
  RxBool isBuffering = false.obs; // Indicates if the video is buffering

  String formatDuration(Duration durationAndPosition) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(durationAndPosition.inHours);
    final minutes = twoDigits(durationAndPosition.inMinutes.remainder(60));
    final seconds = twoDigits(durationAndPosition.inSeconds.remainder(60));
    return [if (durationAndPosition.inHours > 0) hours, minutes, seconds].join(':');
  }

  // Initialize video player with a URL
  void videoPlayerController(String? url) {
    if (url != null) {
      videoController = VideoPlayerController.network(url);

      // Initialize the video player and store the Future.
      initializeVideoPlayerFuture = videoController.initialize().then((_) {
        videoController.setLooping(false);  // Disable looping by default.

      }).catchError((error) {
        print('Error initializing video player: $error');
      });

      // Add a listener to update the UI when the video position changes.
      videoController.addListener(() {
        // Update buffering state
        isBuffering.value = videoController.value.isBuffering;

        // Update the position for the slider
        position.value = videoController.value.position;

        // If the video reaches the end, stop the video
        if(position.value >= videoController.value.duration) {
          position.value = Duration.zero;
          playerState.value = PlayerState.stopped;  // Set player state to 'stopped'
          videoController.seekTo(Duration.zero);    // Seek to the beginning
          videoController.pause();
          print("video stop after complete PSSSSSSSPSSSSSSSSSSSSSSSSS");

        }
      });
    } else {
      print('Error: URL is null');
    }
  }

  void backAction(){
    position.value = Duration.zero;
    playerState.value = PlayerState.stopped;  // Set player state to 'stopped'
    videoController.seekTo(Duration.zero);    // Seek to the beginning
    videoController.pause();
  }

  // Play video or pause

  void playAndPause() {
    if (playerState.value == PlayerState.playing) {
      videoController.pause();
      playerState.value = PlayerState.paused;
      print("video paused. PSSSSSSSPSSSSSSSSSSSSSSSSS");
    } else {
      videoController.play();
      playerState.value = PlayerState.playing;
      print("video playing. PSSSSSSSPSSSSSSSSSSSSSSSSS");
    }
  }


  // Seek to a specific position using the slider
  void sliderPosition(double value) {
    final newPosition = Duration(seconds: value.toInt());
    videoController.seekTo(newPosition);
    position.value = newPosition;  // Update position
  }


  // Dispose video controller when not needed
  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }

}