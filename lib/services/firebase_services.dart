import 'dart:io';

import 'package:breath_in/models/audio_file_model.dart';
import 'package:breath_in/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseServices{

  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
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
      userId: auth.currentUser!.uid,
      createdAt: time,
      userName: name,
      userEmail: email,
      userImage: "",
    );

    return await fireStore
        .collection('BreathInUsers')
        .doc(auth.currentUser!.uid)
        .set(userModel.toJson());
  }
/* -------------------------------------------------------------------------- */
/*                         create Account with Google                         */
/* -------------------------------------------------------------------------- */
  static Future<void> createUserWithGoogleAccount() async {

    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final  userModel =  UserModel(
      userId: auth.currentUser!.uid,
      userName: auth.currentUser!.displayName.toString(),
       userImage: '',
       userEmail:auth.currentUser!.email.toString(),
      createdAt: time,
    );

    return await fireStore
        .collection('BreathInUsers')
        .doc(auth.currentUser!.uid)
        .set(userModel.toJson());
  }

  /* -------------------------------------------------------------------------- */
  /*                              get user information                          */
  /* -------------------------------------------------------------------------- */

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentUser(){
    return FirebaseFirestore.instance.collection('BreathInUsers')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }


  /* -------------------------------------------------------------------------- */
  /*                                get all users                               */
  /* -------------------------------------------------------------------------- */

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(){
    return FirebaseFirestore.instance.collection('BreathInUsers')
        .where('userId', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }


  /* -------------------------------------------------------------------------- */
  /*                         upload audio in Storage                            */
  /* -------------------------------------------------------------------------- */
  static Future<String?> uploadAudioToFirebase(File file) async {
    try {
      // Get the Firebase Storage reference
      FirebaseStorage storage = FirebaseStorage.instance;

      // Create a unique path for the audio file
      String filePath = 'audios/${DateTime.now().millisecondsSinceEpoch}.mp3';

      // Upload the file
      TaskSnapshot uploadTask = await storage.ref(filePath).putFile(file);

      // Get the download URL after successful upload
      String downloadURL = await uploadTask.ref.getDownloadURL();
      addAudioFile(downloadURL);
      return downloadURL;

    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

/* -------------------------------------------------------------------------- */
/*                         add audio in FireStore                             */
/* -------------------------------------------------------------------------- */

  static Future<void> addAudioFile(String fileUrl) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final audiFileModel = AudioFileModel(
      userId: auth.currentUser!.uid,
      audioFile: fileUrl,
      audioName: "",
    );

    return await fireStore
        .collection('BreathInAudios')
        .doc(time)
        .set(audiFileModel.toJson());
  }

  /* -------------------------------------------------------------------------- */
  /*                                   get audios                             */
 /* -------------------------------------------------------------------------- */
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAudioFile(){
    return FirebaseFirestore.instance.collection('BreathInAudios')
        .snapshots();
  }

}