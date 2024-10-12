import 'dart:ui';
import 'package:breath_in/constants/Images_Constant.dart';
import 'package:breath_in/controller/authentication_controller.dart';
import 'package:breath_in/utils/flush_messages.dart';
import 'package:breath_in/views/custom_widgets/custom_button_widget.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/color_constant.dart';
import '../../custom_widgets/custom_text_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthenticationController authenticationController =
      Get.put(AuthenticationController());
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthenticationController>(
        builder: (authenticationController) {
          return Form(
            key: formKey,
            child: Stack(
              children: [
                Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImagesConstant.onBorDingImage),
                          fit: BoxFit.cover)),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 17.0,
                        sigmaY:
                            10.0), // Adjust sigma for the intensity of the blur
                    child: Container(
                      color: Colors.black.withOpacity(
                          0), // This container allows the blur to show, remains transparent
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(30.r),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 70.h,
                        ),
                        CustomText(
                          "Welcome to Breathin",
                          size: 24.sp,
                          fw: FontWeight.w400,
                          color: ColorConstant.whiteColor,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomText(
                          "Please enter your details to continue",
                          size: 16.sp,
                          fw: FontWeight.w400,
                          color: ColorConstant.whiteColor,
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                        CustomText(
                          "Email",
                          size: 14.sp,
                          fw: FontWeight.w400,
                          color: ColorConstant.blackColor,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        CustomTextFormField(
                          hintText: "example@gmail.com",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: ColorConstant.hintTextColor),
                          validateFunction:
                              authenticationController.emailValidate,
                          controller: emailController,
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        CustomText(
                          "Name",
                          size: 14.sp,
                          fw: FontWeight.w400,
                          color: ColorConstant.blackColor,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        CustomTextFormField(
                          hintText: "name",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: ColorConstant.hintTextColor),
                          validateFunction:
                              authenticationController.nameValidate,
                          controller: nameController,
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        CustomText(
                          "Password",
                          size: 14.sp,
                          fw: FontWeight.w400,
                          color: ColorConstant.blackColor,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        CustomTextFormField(
                          hintText: "must be 8 characters",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: ColorConstant.hintTextColor),
                          obSecureTap: () {
                            authenticationController.ObsecureSignup();
                          },
                          isObSecure: authenticationController.signupObSecure,
                          validateFunction:
                              authenticationController.passwordValidate,
                          controller: passwordController,
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        CustomButton(
                          loader: authenticationController.loaderSignup,
                          width: 335.w,
                          height: 50.h,
                          boxColor: ColorConstant.buttonColor,
                          text: "Continue",
                          textColor: ColorConstant.blackColor,
                          fw: FontWeight.w700,
                          fontSize: 16.sp,
                          bordercircular: 10.r,
                          borderColor: Colors.transparent,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              authenticationController.loadingFunctionSignup();
                              auth.createUserWithEmailAndPassword(
                                      email: emailController.text.toString(),
                                      password: passwordController.text.toString())
                                  .then((value) async {
                                authenticationController.loadingFunctionSignup();
                                SharedPreferences sp =
                                    await SharedPreferences.getInstance();
                                sp.setString('name', nameController.text);
                                sp.setString('email', emailController.text);
                                FlushMessagesUtil.snackBarMessage("Success", "SignUp Successfully", context);
                              }).onError((error, stackTrace) {
                                authenticationController.loadingFunctionSignup();
                                FlushMessagesUtil.snackBarMessage("Error", error.toString(), context);
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              "Have an Account?",
                              fw: FontWeight.w400,
                              size: 14.sp,
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: CustomText(
                                  "Sign in",
                                  fw: FontWeight.w400,
                                  size: 16.sp,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
