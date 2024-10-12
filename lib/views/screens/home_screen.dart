import 'package:breath_in/constants/Images_Constant.dart';
import 'package:breath_in/views/custom_widgets/custom_stack_widget.dart';
import 'package:breath_in/views/custom_widgets/Custom_favourite_or_exercise_widgets.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:breath_in/views/custom_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/color_constant.dart';
import 'exercises_and_detail_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     // extendBodyBehindAppBar: true,

      body: Container(
       padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: Column(
          children: [
            CustomTextFormField(
              prefixIcon: Icon(Icons.search,color: ColorConstant.dimGray,),
              isSearch: true,
              hintText: "Search here",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: ColorConstant.dimGray),
              focusedBorderColor: ColorConstant.customGreen,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [

                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText("Favourites",fw: FontWeight.w400,size: 16,color: Colors.black,),
                      CustomText("See All",fw: FontWeight.w400,size: 12,color: Colors.black,),
                    ],),
                  SizedBox(height: 15.h,),
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
                          icon: Icon(Icons.favorite_outlined,color: ColorConstant.redColor,size: 12.sp,),
                          onTab: (){},
                        ),
                    ],),
                  ),
                  SizedBox(height: 25.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText("Featured",fw: FontWeight.w400,size: 16,color: Colors.black,),
                      CustomText("See All",fw: FontWeight.w400,size: 12,color: Colors.black,),
                    ],),
                  SizedBox(height: 15.h,),
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
                          icon: Icon(Icons.favorite_outlined,color: ColorConstant.redColor,size: 12.sp,),
                          onTab: (){},
                        ),
                    ],),
                  ),
                  SizedBox(height: 10.h,),
                  for(int i=0;i<8;i++)
                    CustomStackWidget(image:ImagesConstant.localImage,
                      height: 100.h,
                      width: 335.w,
                      borderRadius: 10.r,
                      textTime: "123 mins",
                      textExercise: "08 Exercice",
                      positionTop: 25.h,
                      positionLeft: 15.w,
                      marginBottom: 10.h,
                      onTab: (){
                      Get.to(()=>ExercisesAndDetailScreen());
                      },
                    )
                ],),
              ),
            ),

          ],
        ),
      ) );
  }
}
