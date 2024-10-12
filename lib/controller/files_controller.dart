import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class FilesController extends GetxController{
  // Lists to store selected files
  List<File>? audioFiles;
  List<File>?  videoFiles;
  List<File>?  imageFiles;
  FileType? fileType;

  // Function to pick multiple audio files
  Future<void> pickAudioFiles() async {
    audioFiles=null;
    videoFiles =null;
    imageFiles=null;
    update();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: true, // Allows selecting multiple files
    );

    if (result != null && result.files.isNotEmpty) {
      audioFiles = result.paths.map((path) => File(path!)).toList();
      fileType=FileType.audio;
      update(); // Update the GetX state
    } else {
      audioFiles=null;
      update();
    }
  }

  // Function to pick multiple video files
  Future<void> pickVideoFiles() async {
    audioFiles=null;
    videoFiles =null;
    imageFiles=null;
    update();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true, // Allows selecting multiple files
    );

    if (result != null && result.files.isNotEmpty) {
      videoFiles = result.paths.map((path) => File(path!)).toList();
      fileType=FileType.video;
      update(); // Update the GetX state
    } else {
      videoFiles=null;
      update();
    }
  }

  // Function to pick multiple image files
  Future<void> pickImageFiles() async {
    audioFiles=null;
    videoFiles =null;
    imageFiles=null;
    update();
    // Request storage permissions at runtime
    var status = await Permission.storage.request();

    if (status.isGranted) {
      // Continue with the file picker
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        imageFiles = result.paths.map((path) => File(path!)).toList();
        fileType = FileType.image;
        update();
      } else {
        imageFiles = null;
        update();
      }
    } else {
      // Handle the case when permission is denied
      print('Storage permission denied');
    }
  }



}