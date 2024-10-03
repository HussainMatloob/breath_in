import 'dart:io';

import 'package:breath_in/services/firebase_services.dart';
import 'package:breath_in/views/screens/navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController extends GetxController{
 bool loginObSecure=true;
 bool signupObSecure=false;
 bool loaderSignup=false;
 bool loaderLogin=false;
 bool loaderForget=false;

 void forGotLoading(){
   loaderForget=!loaderForget;
   update();
 }

 void ObsecureLogin( ){
    loginObSecure= !loginObSecure;
    update();
 }
 void ObsecureSignup( ){
    signupObSecure= !signupObSecure;
    update();
 }

 void loadingFunctionSignup(){
   loaderSignup=!loaderSignup;
   update();
}


void loadingFunctionLogin(){
   loaderLogin=!loaderLogin;
   update();
 }

 String? emailValidate(value)
 {
   if(value==null||value.trim().isEmpty)
   {
     return "Please enter an email";
   }
   bool emailReg=RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value);
   if(emailReg==false)
   {
     return"Please enter valid email";
   }
   return null;
 }

 String? passwordValidate(value)
 {
   if(value==null||value.trim().isEmpty)
   {
     return"Please enter password";
   }
   if (value == null || value.length < 8) {
     return "Password must be at least 8 characters long.";
   }
   return null; // Valid input
 }

 String? nameValidate(value)
 {
   if(value==null||value.trim().isEmpty)
   {
     return "Please enter name";
   }
 }

 void handleGoogleBtnClick() {
   // Dialogs.showProgressBar(context);

   signInWithGoogle().then((value) async {
     //Navigator.pop(context);
     if (value != null) {
       if ((await FirebaseServices.userExists())) {
         Get.to(()=>NavigationScreen());
       } else {
         await FirebaseServices.createUserWithGoogleAccount().then((value) {
           Get.to(()=>NavigationScreen());
         });
       }

       Get.snackbar(
         'Success',
         'You login successfully',
         colorText: Colors.black,
         backgroundColor: Colors.white70,
         snackPosition: SnackPosition.TOP,
         onTap: (SnackBar) {},
       );
     }
   });
 }

 Future<UserCredential?> signInWithGoogle() async {
   try {
     await InternetAddress.lookup('google.com');
     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
     final GoogleSignInAuthentication? googleAuth =
     await googleUser?.authentication;
     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth?.accessToken,
       idToken: googleAuth?.idToken,
     );
     return  FirebaseServices.auth.signInWithCredential(credential);
   } catch (e) {
     Get.snackbar(
       'Error',
        e.toString(),
       colorText: Colors.black,
       backgroundColor: Colors.white70,
       snackPosition: SnackPosition.TOP,
       onTap: (SnackBar) {},
     );
     return null;
   }
 }

}
