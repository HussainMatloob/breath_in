import 'dart:io';
import 'dart:ui';
import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/controller/authentication_controller.dart';
import 'package:breath_in/services/firebase_services.dart';
import 'package:breath_in/views/custom_widgets/custom_button_widget.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:breath_in/views/custom_widgets/custom_text_form_field.dart';
import 'package:breath_in/views/screens/Authentication/forget_password.dart';
import 'package:breath_in/views/screens/Authentication/signup_screen.dart';
import 'package:breath_in/views/screens/choose_language_screen.dart';
import 'package:breath_in/views/screens/navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../constants/Images_Constant.dart';
import '../../../utils/flush_messages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final auth=FirebaseAuth.instance;
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  AuthenticationController authenticationController=Get.put(AuthenticationController());




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthenticationController>(
        builder: (authenticationController){
          return  Form(
            key:formKey,
            child: Stack(children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                    image:  DecorationImage(image: AssetImage(ImagesConstant.loginPageImage),
                        fit: BoxFit.cover
                    )
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 17.0, sigmaY: 10.0), // Adjust sigma for the intensity of the blur
                  child: Container(
                    color: Colors.black.withOpacity(0), // This container allows the blur to show, remains transparent
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(30.r),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 70.h,),
                      CustomText("Welcome to Breathin",size: 24.sp,fw: FontWeight.w400,color: ColorConstant.whiteColor,),
                      SizedBox(height: 5.h,),
                      CustomText("Please enter your details to continue",size: 16.sp,fw: FontWeight.w400,color: ColorConstant.whiteColor,),
                      SizedBox(height: 60.h,),
                      CustomText("Email",size: 14.sp,fw: FontWeight.w400,color: ColorConstant.blackColor,),
                      SizedBox(height: 4.h,),
                      CustomTextFormField(
                        hintText: "example@gmail.com",
                        hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 12.sp,color:ColorConstant.hintTextColor ),
                        validateFunction: authenticationController.emailValidate,
                        controller: emailController,
                      ),
                      SizedBox(height: 25.h,),
                      CustomText("Password",size: 14.sp,fw: FontWeight.w400,color: ColorConstant.blackColor,),
                      SizedBox(height: 4.h,),
                      CustomTextFormField(
                        hintText: "must be 8 characters",
                        hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 12.sp,color:ColorConstant.hintTextColor ),
                        obSecureTap: (){
                            authenticationController.ObsecureLogin();
                        },
                         isObSecure: authenticationController.loginObSecure,
                        validateFunction: authenticationController.passwordValidate,
                        controller: passwordController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        TextButton(onPressed: ( ){
                          Get.to(( )=>  ForgetPassword());
                        }, child: CustomText("Forget Password?",fw: FontWeight.w400,size: 14.sp,color: ColorConstant.blackColor,))
                      ],),
                      Row(children: [
                        Container(
                          width: 25.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: ColorConstant.blackColor
                          ),
                          child: Center(child: Icon(Icons.check,color: ColorConstant.whiteColor,size: 11.sp,),),
                        ),
                        SizedBox(width: 10.w,),
                        CustomText("I accept the terms and privacy Policy")
                      ],),
                      SizedBox(height: 20.h,),
                      CustomButton(
                        loader: authenticationController.loaderLogin,
                        width: 335.w,
                        height: 50.h,
                        boxColor: ColorConstant.buttonColor,
                        text: "Continue",
                        textColor: ColorConstant.blackColor,
                        fw: FontWeight.w700,
                        fontSize: 16.sp,
                        bordercircular: 10.r,
                        borderColor: Colors.transparent,
                        onTap: (){
                          if(formKey.currentState!.validate()){
                            {
                              authenticationController.loadingFunctionLogin();
                              auth.signInWithEmailAndPassword(email:emailController.text.toString(),
                                  password: passwordController.text.toString()).then((value) async{
                                authenticationController.loadingFunctionLogin();
                                if (value != null) {
                                  if ((await FirebaseServices.userExists())) {
                                    Get.to(()=>ChooseLanguageScreen());
                                  } else {
                                    await FirebaseServices.createUserWithEmailOrContact().then((value) {
                                      Get.to(()=>ChooseLanguageScreen());
                                    });
                                  }
                                  FlushMessagesUtil.snackBarMessage("Success", "Login Successfully", context);
                                }
                              }).onError((error, stackTrace){
                                authenticationController.loadingFunctionLogin();
                                FlushMessagesUtil.snackBarMessage("Error", error.toString(), context);
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 50.h,),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                         Container(width: 141,
                         decoration: BoxDecoration(border: Border.all(width: 0.7.w,color: Colors.white70)),),
                          SizedBox(width: 5.w,),
                            CustomText("or",size: 16.sp,fw: FontWeight.w400,color: ColorConstant.whiteColor,),
                            SizedBox(width: 5.w,),
                            Container(width: 141,
                            decoration: BoxDecoration(border: Border.all(width: 0.7.w,color: Colors.white70)),),
                        ],),
                      ),
                      SizedBox(height: 20.h,),
                      CustomButton(
                        width: 335.w,
                        height: 48.h,
                         image: ImagesConstant.googleImage,
                        text: "Sign in with Google",
                        textColor: ColorConstant.blackColor,
                        fw: FontWeight.w400,
                        fontSize: 14.sp,
                        bordercircular: 10.r,
                        boxColor: ColorConstant.whiteColor,
                        onTap: () async{
                         authenticationController.handleGoogleBtnClick(context);
                        },
                      ),
                      SizedBox(height: 10.h,),
                      CustomButton(
                        width: 335.w,
                        height: 48.h,
                        image: ImagesConstant.appleImage,
                        text: "Sign in with Apple",
                        textColor: ColorConstant.blackColor,
                        fw: FontWeight.w400,
                        fontSize: 14.sp,
                        bordercircular: 10.r,
                        boxColor: ColorConstant.whiteColor,
                        onTap: (){
                          authenticationController.signInWithApple(context);
                        },
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        CustomText("Don't have an Account?",fw: FontWeight.w400,size: 14.sp,),
                          TextButton(onPressed: (){
                            Get.to(()=>SignupScreen());
                          }, child:CustomText("Signup",fw: FontWeight.w400,size: 16.sp,))
                      ],)
                    ],),
                ),
              )
            ],),
          );
        },

      ),
    );
  }
}
