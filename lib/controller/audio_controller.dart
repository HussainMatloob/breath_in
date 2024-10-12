import 'package:get/get.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';



class AudioController extends GetxController{

  final AudioPlayer audioPlayer=AudioPlayer();
  Rx<PlayerState> playerState = PlayerState.stopped.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> position = Duration.zero.obs;
  Rx<bool> isLoading = false.obs; // Track loading state

  void loaderValue(){
    isLoading.value=false;
  }

  @override
  void onInit() async{
    super.onInit();
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    // Update duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      duration.value = newDuration;
    });

    // Update position in real-time
    audioPlayer.onPositionChanged.listen((newPosition) {
      position.value = newPosition;
    });

    //Update player state
    audioPlayer.onPlayerStateChanged.listen((newState) {
      playerState.value = newState;
    });

    // Reset position on completion
    audioPlayer.onPlayerComplete.listen((event) {
        playerState.value = PlayerState.completed;
        position.value = Duration.zero;
    });

  }

  Future <void> play(String source) async {
    try {
      isLoading.value = true;
      if (source.contains('http') || source.contains('https')) {

        // If the source is a URL, use NetworkSource
        await audioPlayer.stop();
        await audioPlayer.setSource(UrlSource(source));
        await audioPlayer.play(UrlSource(source));
        playerState.value = PlayerState.playing;

        isLoading.value = false;
         // Update player state
      } else {
        // If the source is an asset, use AssetSource
        await audioPlayer.stop();
        await audioPlayer.play(AssetSource(source));
         playerState.value = PlayerState.playing;
      }
    } catch (e) {
      print("Error during play: $e");
      playerState.value = PlayerState.stopped; // Reset to stopped on error
    }
  }


  Future<void> pauseOrResume(String source) async{

      try{
        if(playerState.value==PlayerState.playing){
          isLoading.value = false;
          audioPlayer.pause();
          playerState.value = PlayerState.paused;


        }else if(playerState.value==PlayerState.paused){
          isLoading.value = false;
          audioPlayer.resume();
          playerState.value = PlayerState.playing;

        }else{
          isLoading.value = true;
          playerState.value = PlayerState.playing;
          await audioPlayer.setSource(UrlSource(source));
          await audioPlayer.play(UrlSource(source));

          isLoading.value = false;
        }
      }catch(e){
        print("Error during pause/resume: $e");
      }
  }

 void stop() async {
  try {
    isLoading.value = false;
    await audioPlayer.stop();
    playerState.value = PlayerState.stopped;
    position.value = Duration.zero;

  } catch (e) {
    print("Error during stop: $e");
  }
  }

  void seek(double value) {
    try {
      audioPlayer.seek(Duration(seconds: value.toInt()));
    } catch (e) {
      print("Error during seek: $e");
    }
  }

String formatTime(Duration positionAndDuration){
    String twoDigitSecond=positionAndDuration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formatedTime="${positionAndDuration.inMinutes}:$twoDigitSecond";
    return formatedTime;
}

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

}




// void playNextSong() {
//   if(_currentSongIndex!=null){
//     currentSongIndex=_currentSongIndex!+1;
//   }else{
//     currentSongIndex=0;
//   }
// }
//
// void playPreviousSong(){
//   if(position.value.inSeconds>2){
//      Duration.zero;
//   }else{
//     if(_currentSongIndex!>0){
//       currentSongIndex=_currentSongIndex!-1;
//     }else{
//       currentSongIndex=_playList.length-1;
//     }
//   }
// }
