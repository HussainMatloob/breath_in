import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MessagesController extends GetxController {
  FlutterSoundRecorder? recorder;
  bool isRecording = false;
  String? filePath;

  @override
  void onInit() {
    super.onInit();
    recorder = FlutterSoundRecorder();
    initRecorder();
  }

  Future<void> initRecorder() async {
    // Check if the recorder is already initialized
    if (recorder == null) {
      recorder = FlutterSoundRecorder(); // Initialize the recorder
    }

    // Check if the recorder is not already opened
    if (recorder!.isStopped) {
      // Request microphone permission
      var status = await Permission.microphone.request();

      // Check if the permission is granted
      if (status.isGranted) {
        await recorder!.openRecorder();
      } else {
        // Handle the case when permission is not granted
        throw RecordingPermissionException("Microphone permission not granted");
      }
    }
  }

  Future<void> startRecording() async {
    if (recorder!.isStopped) { // Check if the recorder is not already recording
      Directory tempDir = Directory.systemTemp;
      String path = '${tempDir.path}/voice_message.aac';
      await recorder!.startRecorder(toFile: path);
      isRecording = true;
      filePath = path;
      update();
    }
  }

  Future<void> stopRecording() async {
    if (recorder!.isRecording) { // Check if it's currently recording before stopping
      await recorder!.stopRecorder();
      isRecording = false;
      update();
    }
  }

  @override
  void dispose() {
    if (recorder != null) {
      recorder!.closeRecorder(); // Ensure the recorder is closed when disposing
    }
    super.dispose();
  }
}
