import 'dart:io';

import 'package:breath_in/services/firebase_services.dart';
import 'package:breath_in/utils/flush_messages.dart';
import 'package:breath_in/views/screens/choose_language_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthenticationController extends GetxController{
 bool loginObSecure=true;
 bool signupObSecure=false;
 bool loaderSignup=false;
 bool loaderLogin=false;
 bool loaderForget=false;
 String? userIdentifier;
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


 /* -------------------------------------------------------------------------- */
/*                                  Sign in Google                             */
/* -------------------------------------------------------------------------- */

 void handleGoogleBtnClick(BuildContext context) {
   // Dialogs.showProgressBar(context);

   signInWithGoogle(context).then((value) async {
     //Navigator.pop(context);
     if (value != null) {
       if ((await FirebaseServices.userExists())) {
         Get.to(()=>ChooseLanguageScreen());
       } else {
         await FirebaseServices.createUserWithGoogleAccount().then((value) {
           Get.to(()=>ChooseLanguageScreen());
         });
       }
       FlushMessagesUtil.snackBarMessage( 'Success', 'You login successfully', context);
     }
   });
 }


 Future<UserCredential?> signInWithGoogle(context) async {
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
     FlushMessagesUtil.snackBarMessage("Error", e.toString(), context);
     return null;
   }
 }

  /* --------------------------------------------------------------------------*/
 /*                                  Sign in with Apple                        */
 /* -------------------------------------------------------------------------- */

 Future<void> signInWithApple(BuildContext context) async {
   try {
     final appleCredential = await SignInWithApple.getAppleIDCredential(
       scopes: [
         AppleIDAuthorizationScopes.email,
         AppleIDAuthorizationScopes.fullName,
       ],
     );
     // Use the appleCredential to authenticate with your backend server
       userIdentifier = appleCredential.userIdentifier;
       update();
   } catch (error) {
      FlushMessagesUtil.snackBarMessage("Error", error.toString(), context);
   }
 }

  List<Country> allCountries = CountryService().getAll();
  List<Country> filteredCountries = CountryService().getAll();
  int? selectedIndex;

  void filterCountries(String query) {
      filteredCountries = allCountries
          .where((country) =>
          country.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      update();
  }
  void selectCountry(int index) {
    selectedIndex = index; // Update selected index
    update(); // Trigger UI update
  }
}
