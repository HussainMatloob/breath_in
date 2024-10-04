 import 'package:breath_in/constants/Images_Constant.dart';
import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/views/custom_widgets/custom_Image.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStackWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String? image;
  final Icon? icon;
  final String? heading;
  final String? text;
  final String? textTime;
  final String? textExercise;
  final double? fw;
  final double? size;
  final double? fwTime;
  final double? sizeTime;
  final double? fwExercise;
  final double? sizeExercise;
  final Color? textColor;
  final double? borderRadius;
  final VoidCallback? onTab;
  final double? positionLeft;
  final double? positionRight;
  final double? positionTop;
  final double? positionBottom;
  final double? marginBottom;
  final double? marginAll;
   const CustomStackWidget({super.key, this.height, this.width, this.image, this.icon, this.heading, this.textTime, this.fw, this.size, this.textColor, this.borderRadius, this.onTab, this.text, this.textExercise, this.fwTime, this.sizeTime, this.fwExercise, this.sizeExercise, this.positionLeft, this.positionRight, this.positionTop, this.positionBottom, this.marginBottom, this.marginAll});
   @override
   Widget build(BuildContext context) {
     return Column(
       children: [
          GestureDetector(
            onTap:  onTab,
            child: Container(
              margin: EdgeInsets.only(bottom: marginBottom??0.r),
              child: Stack(children: [
                CustomImage(
                  image: ImagesConstant.localImage,
                  height: height,
                  width: width,
                  borderRadius: borderRadius,
                ),
                Positioned(
                  top: positionTop,
                  left: positionLeft,
                  child: Container(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    CustomText(textTime,fw: FontWeight.w400,size: 16.sp,color: ColorConstant.whiteColor,),
                    CustomText(textExercise,fw: FontWeight.w400,size: 12.sp,color: ColorConstant.whiteColor,),
                  ],),),
                )
              ],),
                     ),
          ),
       ],
     );
   }
 }
