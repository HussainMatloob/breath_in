import 'dart:io';
import 'package:breath_in/models/audio_file_model.dart';
import 'package:breath_in/models/image_model.dart';
import 'package:breath_in/models/messages_model.dart';
import 'package:breath_in/models/user_model.dart';
import 'package:breath_in/models/video_model.dart';
import 'package:breath_in/utils/flush_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseServices{

  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static User get user => auth.currentUser!;
  static Future<bool> userExists() async {
    return (await fireStore.collection('BreathInUsers').doc(auth.currentUser!.uid).get()).exists;
  }

/* -------------------------------------------------------------------------- */
/*                       create Account with Email and Password               */
/* -------------------------------------------------------------------------- */
  static Future<void> createUserWithEmailOrContact() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? name = sp.getString('name');
    String? email = sp.getString('email');
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final userModel = UserModel(
      userId:user.uid,
      createdAt: time,
      userName: name,
      userEmail: email,
      userImage: "",
    );

    return await fireStore
        .collection('BreathInUsers')
        .doc(user.uid)
        .set(userModel.toJson());
  }
/* -------------------------------------------------------------------------- */
/*                         create Account with Google                         */
/* -------------------------------------------------------------------------- */
  static Future<void> createUserWithGoogleAccount() async {

    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final  userModel =  UserModel(
      userId:user.uid,
      userName: auth.currentUser!.displayName.toString(),
       userImage: '',
       userEmail:auth.currentUser!.email.toString(),
      createdAt: time,
    );

    return await fireStore
        .collection('BreathInUsers')
        .doc(user.uid)
        .set(userModel.toJson());
  }

  /* -------------------------------------------------------------------------- */
  /*                              get user information                          */
  /* -------------------------------------------------------------------------- */

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentUser(){
    return FirebaseFirestore.instance.collection('BreathInUsers')
        .where('userId', isEqualTo: user.uid)
        .snapshots();
  }


  /* -------------------------------------------------------------------------- */
  /*                                get all users                               */
  /* -------------------------------------------------------------------------- */


  static Query<Map<String, dynamic>> getAllUsers(){
    return  FirebaseFirestore.instance.collection('BreathInUsers')
        .where('userId', isNotEqualTo: user.uid).orderBy('userId');
  }


  /* -------------------------------------------------------------------------- */
  /*                  upload audio or video or image file in Storage            */
  /* -------------------------------------------------------------------------- */

  static Future<List<String?>> uploadFilesToFirebaseStorage(List<File> files, String folder, FileType fileType,BuildContext context) async {
    List<String?> downloadUrls = [];

    for (File file in files) {
      try {
        // Determine the correct file extension
        String fileExtension;
        if (fileType == FileType.audio || fileType == FileType.video) {
          fileExtension = 'mp3'; // Save audio and video as .mp3
        } else if (fileType == FileType.image) {
          fileExtension = 'png'; // Save images as .png
        } else {
          fileExtension = 'unknown'; // Handle unsupported file types
          continue; // Skip unsupported files
        }

        // Create a unique file name with the appropriate extension
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

        // Reference to the Firebase Storage folder
        final ref = FirebaseStorage.instance.ref().child('$folder/$fileName');

        // Upload the file to Firebase Storage
        final uploadTask = ref.putFile(file);

        // Wait for the upload to complete
        final snapshot = await uploadTask.whenComplete(() => null);

        // Get the download URL and add it to the list
        final downloadUrl = await snapshot.ref.getDownloadURL();
        //downloadUrls.add(downloadUrl);

        if(fileType==FileType.audio){
          addAudioFile(downloadUrl);
        }
        if(fileType==FileType.video){
          addVideoFile(downloadUrl);
        }
        if(fileType==FileType.image){
          addImageFile(downloadUrl);
        }

      } catch (e) {
        EasyLoading.dismiss();
        FlushMessagesUtil.snackBarMessage("Error", e.toString(), context);
        downloadUrls.add(null); // Add null to indicate failure for this file
      }
    }

    return downloadUrls; // Return the list of download URLs
  }

/* -------------------------------------------------------------------------- */
/*                         add audio in FireStore                             */
/* -------------------------------------------------------------------------- */

  static Future<void> addAudioFile(String fileUrl) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final audiFileModel = AudioFileModel(
      userId: user.uid,
      audioFile: fileUrl,
      audioName: "",
    );

    return await fireStore
        .collection('BreathInAudios')
        .doc(time)
        .set(audiFileModel.toJson());
  }

  /* -------------------------------------------------------------------------- */
  /*                         add video in FireStore                             */
  /* -------------------------------------------------------------------------- */

  static Future<void> addVideoFile(String fileUrl) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final  videoModel =  VideoModel(
      userId:user.uid,
      videoFile: fileUrl,
      videoName: ""
    );

    return await fireStore
        .collection('BreathInVideos')
        .doc(time)
        .set(videoModel.toJson());
  }
  /* -------------------------------------------------------------------------- */
  /*                         add image in FireStore                             */
  /* -------------------------------------------------------------------------- */
  static Future<void> addImageFile(String fileUrl) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final   imageModel=  ImageModel(
        userId: user.uid,
        imageFile: fileUrl,
        imageName: ""
    );

    return await fireStore
        .collection('BreathInImages')
        .doc(time)
        .set(imageModel.toJson());
  }

  /* -------------------------------------------------------------------------- */
  /*                                   get audios                             */
 /* -------------------------------------------------------------------------- */
  static  Query<Map<String, dynamic>> getAudioFile(){
    return FirebaseFirestore.instance.collection('BreathInAudios');
  }

  /* -------------------------------------------------------------------------- */
  /*                                  get videos                                */
  /* -------------------------------------------------------------------------- */

  static Query<Map<String, dynamic>> getVideosFile(){
    return FirebaseFirestore.instance.collection('BreathInVideos');
  }

  /* -------------------------------------------------------------------------- */
  /*                                 send Message                               */
  /* -------------------------------------------------------------------------- */

  static String getConservationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  static Future<void> sendMessage(UserModel userModel,String message,String type) async {

    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final  messagesModel =  MessagesModel(
        id: time,
        isLive: false,
        senderId:user.uid,
        receiverId: userModel.userId,
        idCombination:"${getConservationID(userModel.userId!)}",
        message: message,
      messageType: type
    );

    return await fireStore
        .collection('BreathInChats')
        .doc("${getConservationID(userModel.userId!)}").collection("Messages").doc(time)
        .set(messagesModel.toJson());
  }

  /* -------------------------------------------------------------------------- */
  /*                                   getMessages                              */
  /* -------------------------------------------------------------------------- */

  static  Query<Map<String, dynamic>> getMessages(UserModel userModel){
    return  fireStore
        .collection('BreathInChats')
        .doc("${getConservationID(userModel.userId!)}").collection("Messages").orderBy('id', descending: true);
  }

  /* -------------------------------------------------------------------------- */
  /*                 Upload VoiceMessage To Firebase Storage                    */
  /* -------------------------------------------------------------------------- */

  static Future<void> uploadVoiceMessage(UserModel userModel, String filePath) async {
    File voiceFile = File(filePath);
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      TaskSnapshot uploadTask = await storage
          .ref('voice_messages/${userModel.userId}/$fileName.aac')
          .putFile(voiceFile);

      // Get the download URL
      String downloadUrl = await uploadTask.ref.getDownloadURL();

      // Store voice url to fireStore
      await sendMessage(userModel,downloadUrl,"voice");
      print('Voice message URL saved to Firestore');
    } catch (e) {
      print('Error uploading voice message: $e');
    }
  }

}