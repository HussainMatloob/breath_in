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

}