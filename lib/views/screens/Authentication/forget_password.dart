import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/controller/authentication_controller.dart';
import 'package:breath_in/utils/flush_messages.dart';
import 'package:breath_in/views/custom_widgets/custom_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../custom_widgets/custom_text.dart';
import '../../custom_widgets/custom_text_form_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey=GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final auth=FirebaseAuth.instance;
    AuthenticationController authenticationController=Get.put(AuthenticationController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w,top: 20.h),
          child: CustomButton(
          width: 39.w,
            height: 39.h,
            bordercircular: 10.r,
            icon: Icon(Icons.arrow_back_ios_new,color: ColorConstant.blackColor,size: 20.sp,),
            onTap: (){
             Get.back();
            },
            borderColor:ColorConstant.borderColor,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: GetBuilder<AuthenticationController>(
        builder: (authenticationController){
          return  Form(
            key:formKey,
            child: Container(
                padding: EdgeInsets.all(30.r),
                height: Get.height,
                color: ColorConstant.whiteColor,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 110.h,),
                      CustomText("Forget password?",size: 24.sp,fw: FontWeight.w400,color: ColorConstant.blackColor,),
                      SizedBox(height: 5.h,),
                      CustomText("Don't worry! it happens. Please enter the amail associated with your account.",size: 16.sp,fw: FontWeight.w400,color: ColorConstant.dimGray,),
                      SizedBox(height: 50.h,),
                      CustomText("Email",size: 14.sp,fw: FontWeight.w400,color: ColorConstant.blackColor,),
                      SizedBox(height: 4.h,),
                      CustomTextFormField(
                        hintText: "example@gmail.com",
                        hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 12.sp,color:ColorConstant.hintTextColor ),
                        validateFunction: authenticationController.emailValidate,
                        borderColor: ColorConstant.borderColor,
                        controller: emailController,
                      ),

                      SizedBox(height: 50.h,),
                      CustomButton(
                        loader: authenticationController.loaderForget,
                        width: 335.w,
                        height: 50.h,
                        boxColor: ColorConstant.buttonColor,
                        text: "Verify",
                        textColor: ColorConstant.blackColor,
                        fw: FontWeight.w700,
                        fontSize: 16.sp,
                        bordercircular: 10.r,
                        borderColor: Colors.transparent,
                        onTap: (){
                          if(formKey.currentState!.validate())
                          {
                            authenticationController.forGotLoading();
                            auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                              authenticationController.forGotLoading();
                              FlushMessagesUtil.snackBarMessage("Success", "We have send you email to recover password please check email", context);
                            }).onError((error, stackTrace){
                               authenticationController.forGotLoading();
                               FlushMessagesUtil.snackBarMessage("Error",  error.toString(), context);
                            });
                          }
                        },
                      ),
                    ],),
                ),
              )

          );
        },

      ),
    );
  }
}
