import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/Images_Constant.dart';
import '../custom_widgets/Custom_favourite_or_exercise_widgets.dart';
import '../custom_widgets/custom_button_widget.dart';
import '../custom_widgets/custom_post_widget.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText("Sleep",fw: FontWeight.w400,size: 16.sp,color: Colors.black,),
        leading: Padding(
          padding: EdgeInsets.all(12.r),
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
        actions: [

          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert, color: Colors.black), // Replace with your color
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading:  CustomText("Save",fw: FontWeight.w400,size: 12.sp,color: ColorConstant.blackColor,),
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading:  CustomText("Download",fw: FontWeight.w400,size: 12.sp,color: ColorConstant.blackColor,),
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 3,
                child: ListTile(
                  leading:  CustomText("Report",fw: FontWeight.w400,size: 12.sp,color: ColorConstant.redColor,),
                ),
              ),
            ],
          ),
          SizedBox(width: 5.w,),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            CustomPostWidget(
              image: ImagesConstant.localImage,
              height: 164.h,
              width: 335.w,
              borderRadius: 12.r,
              date: "Aug 1,2021",
              views: "3432 views",
              text: "How do we control our sleep and be happy in our fives 10 secret tips!",
              icon: Icon(Icons.share,color: ColorConstant.iconColor,),
              details: "Breathing is a fundamental process that fuels the human body with oxygen, allowing all vital organs to function efficiently. It begins with inhalation, where air rich in oxygen enters the lungs. This oxygen is then transferred into the bloodstream, where it nourishes cells throughout the body. Exhalation follows, releasing carbon dioxide, a waste product of cellular respiration.",
              name: "By:muhammad Ali",

            ),
            CustomText("Exercises",fw: FontWeight.w400,size: 16,color: Colors.black,),
            SizedBox(height: 10.h,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                for(int i=0;i<9;i++)
                  CustomFavouriteorExerciceWidget(
                    heading: "Drift Off",
                    textTime: "17 mis",
                    textSleep: "Sleep",
                    height: 102.h,
                    width: 127.w,
                    borderRadius: 10.r,
                    image: ImagesConstant.localImage,
                    onTab: (){},
                  ),
              ],),
            )
          ],),
        ),
      ),
    );
  }
}
