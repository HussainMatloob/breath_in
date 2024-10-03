import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/views/custom_widgets/custom_Image.dart';
import 'package:breath_in/views/custom_widgets/custom_button_widget.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFavouriteorExerciceWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String? image;
  final Icon? icon;
  final String? heading;
  final String? textTime;
  final String? textSleep;
  final double? fw;
  final double? size;
  final Color? textColor;
  final double? borderRadius;
  final VoidCallback? onTab;
  const CustomFavouriteorExerciceWidget({super.key, this.height, this.width, this.image, this.icon,  this.fw, this.size, this.textColor, this.borderRadius, this.heading, this.textTime, this.textSleep, this.onTab});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius??0.r),
              ),

               child: Stack(children: [
                 InkWell(
                   onTap: onTab,
                    child: CustomImage(
                      image: image,
                      height: height,
                      width: width,
                      borderRadius: borderRadius,
                    ),
                 ),
                 Positioned(
                     top: 5.h,
                     right: 5.w,
                     child: CustomButton(
                       height: 18.h,
                       width: 18.w,
                       boxColor: Colors.white24,
                       icon: icon,
                      borderColor: Colors.transparent,
                     )),
               ],),
            ),
          SizedBox(height: 5.r,),
          CustomText(heading,fw: FontWeight.w400,size: 14.sp,color: ColorConstant.blackColor,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            CustomText(textTime,fw: FontWeight.w400,size: 10.sp,color: ColorConstant.textColor,),
           SizedBox(width: 10.w,),
           Container(
             padding: EdgeInsets.all(3.r),
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.r),
               color: Colors.black,
             ),

           ),
            SizedBox(width: 5.w,),
            CustomText(textSleep,fw: FontWeight.w400,size: 10.sp,color: ColorConstant.blackColor,),
          ],)
        ],),
      ),
    );
  }
}
