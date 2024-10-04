import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class AudioController extends GetxController{
  File? Url;
     // Function to pick an audio file and return a File
     Future<File?> pickAudioFile() async {
       FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);

       if (result != null && result.files.isNotEmpty) {
         // Return the File from the result
         Url=File(result.files.single.path!);
         update();
         return File(result.files.single.path!);
       } else {
         // Return null if no file was selected
         return null;
       }
     }

     
  late AudioPlayer audioPlayer;
  Rx<PlayerState> playerState = PlayerState.stopped.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> position = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
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

    // Update player state
    audioPlayer.onPlayerStateChanged.listen((newState) {
      playerState.value = newState;
    });

    // Reset position on completion
    audioPlayer.onPlayerComplete.listen((event) {
      playerState.value = PlayerState.completed;
      position.value = Duration.zero;
    });
  }

  Future<void> play(String source) async {
    if (source.contains('http') || source.contains('https')) {
      // If the source is a URL, use NetworkSource
      await audioPlayer.setSourceUrl(source);
    } else {
      // If the source is an asset, use AssetSource
      await audioPlayer.setSource(AssetSource(source));
    }

    await audioPlayer.resume();
    playerState.value = PlayerState.playing;
  }

  Future<void> pause() async {
    await audioPlayer.pause();
    playerState.value = PlayerState.paused;
  }

  Future<void> stop() async {
    await audioPlayer.stop();
    playerState.value = PlayerState.stopped;
    position.value = Duration.zero;
  }

  void seek(double value) {
    audioPlayer.seek(Duration(seconds: value.toInt()));
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }


}