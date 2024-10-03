import 'dart:ui';
import 'package:breath_in/constants/Images_Constant.dart';
import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/views/custom_widgets/custom_button_widget.dart';
import 'package:breath_in/views/custom_widgets/custom_wellcome_widget.dart';
import 'package:breath_in/views/screens/Authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class WellComeScreen extends StatefulWidget {
  const WellComeScreen({super.key});
  @override
  State<WellComeScreen> createState() => _WellComeScreenState();
}
class _WellComeScreenState extends State<WellComeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
                children: [
                  Container(
                    height: Get.height,
                    width: Get.width,
                    decoration: BoxDecoration(
                        image:  DecorationImage(image: AssetImage(ImagesConstant.onBorDingImage),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 1.0), // Adjust sigma for the intensity of the blur
                      child: Container(
                        color: Colors.black.withOpacity(0), // This container allows the blur to show, remains transparent
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: ColorConstant.borDingGradiantColor,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.057, 0.7606], // 5.7% and 56.06%
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(30.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                                CustomWellComeStack(
                                  headingText: "Welcome to Breathin",
                                  headingTextFw: FontWeight.w400,
                                  headingTextSize: 24.sp,
                                  text: "Take Care of your hives through Breathin",
                                  textSize: 16,
                                  textFw: FontWeight.w400,
                                  textColor: ColorConstant.textColor,
                                ),
                          SizedBox(height: 25.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButton(
                                    width: 16.w,
                                    height: 8.h,
                                    boxColor: ColorConstant.grayColor,
                                    borderColor: Colors.transparent,
                                  ),
                                  SizedBox(width: 5.w,),
                                  CustomButton(
                                    width: 8.w,
                                    height: 8.h,
                                    boxColor: ColorConstant.dimGray,
                                    borderColor: Colors.transparent,
                                  ),
                                  SizedBox(width: 5.w,),
                                  CustomButton(
                                    width: 8.w,
                                    height: 8.h,
                                    boxColor: ColorConstant.dimGray,
                                    borderColor: Colors.transparent,
                                  )
                                ],
                              ),
                          SizedBox(height: 25.h,),
                          CustomButton(
                          width: 322.w,
                            height: 50.h,
                            borderColor: Colors.transparent,
                            text: "Get Started",
                            textColor: ColorConstant.textColor,
                            boxColor: ColorConstant.buttonColor,
                            fontSize: 16.sp,
                            fw: FontWeight.w700,
                            onTap: (){
                            Get.to(()=>LoginScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

              ),

      ),
    );
  }
}
