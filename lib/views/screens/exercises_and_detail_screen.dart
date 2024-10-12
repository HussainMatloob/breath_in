import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/controller/exercises_screen_controller.dart';
import 'package:breath_in/views/screens/artist_screen.dart';
import 'package:breath_in/views/screens/mode_screen.dart';
import 'package:breath_in/views/screens/track_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../custom_widgets/custom_button_widget.dart';
import '../custom_widgets/custom_text.dart';

class ExercisesAndDetailScreen extends StatefulWidget {
  const ExercisesAndDetailScreen({super.key});

  @override
  State<ExercisesAndDetailScreen> createState() => _ExercisesAndDetailScreenState();
}

class _ExercisesAndDetailScreenState extends State<ExercisesAndDetailScreen> {
  ExerciseController exerciseController=Get.put(ExerciseController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseController>(
      builder: (exerciseController){
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: CustomText("10 Minutes",fw: FontWeight.w400,size: 16.sp,color: Colors.black,),
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
          ),
          body:Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                              color: ColorConstant.whiteColor,
                              borderRadius: BorderRadius.circular(7.r),
                              boxShadow: [BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                blurRadius: 0.9.r,
                                spreadRadius: 0.1.r,
                                offset: Offset(0, 0),
                              )]
                          ),
                          child: Row(
                            children: [
                              CustomButton(
                                height: 48.h,
                                width: 111.w,
                                boxColor:exerciseController.selectedTab=="Tracks"? ColorConstant.buttonColor:ColorConstant.whiteColor,
                                bordercircular: 7.r,
                                text: "Tracks",
                                borderColor: Colors.transparent,
                                onTap: (){
                                  exerciseController.selectTab("Tracks");
                                },
                              ),
                              CustomButton(
                                height: 48.h,
                                width: 111.w,
                                boxColor: exerciseController.selectedTab=="Modes"? ColorConstant.buttonColor:ColorConstant.whiteColor,
                                bordercircular: 7.r,
                                text: "Modes",
                                borderColor: Colors.transparent,
                                onTap: (){
                                  exerciseController.selectTab("Modes");
                                },
                              ),
                              CustomButton(
                                height: 48.h,
                                width: 111.w,
                                boxColor: exerciseController.selectedTab=="Artist"? ColorConstant.buttonColor:ColorConstant.whiteColor,
                                bordercircular: 7.r,
                                text: "Artist",
                                borderColor: Colors.transparent,
                                onTap: (){
                                  exerciseController.selectTab("Artist");
                                },
                              ),
                            ],),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      if(exerciseController.selectedTab=="Tracks")
                        TrackScreen(),
                      if(exerciseController.selectedTab=="Modes")
                        ModeScreen(),
                      if(exerciseController.selectedTab=="Artist")
                        ArtistScreen(),

                    ],
                  ),
                ),

        );
      },
    );
  }
}
