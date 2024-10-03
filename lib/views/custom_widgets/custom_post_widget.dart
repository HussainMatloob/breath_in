import 'package:breath_in/constants/Images_Constant.dart';
import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/views/custom_widgets/custom_button_widget.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_Image.dart';

class CustomPostWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String? image;
  final Icon? icon;
  final String? text;
  final String? details;
  final String? date;
  final String? views;
  final String? name;
  final double? fw;
  final double? size;
  final Color? textColor;
  final double? borderRadius;
  final VoidCallback? onTab;
  const CustomPostWidget({super.key, this.height, this.width, this.image, this.icon, this.text, this.details, this.fw, this.size, this.textColor, this.borderRadius, this.onTab, this.date, this.views, this.name});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(bottom: 40.h),
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
                  bottom: 5.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal:  10.w),
                    color: Colors.white24,

                    width: width,
                    height: 21.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      CustomButton(
                        boxColor:ColorConstant.customGreen ,
                        height: 21.h,
                        width: 31.w,
                        text: "Sleep",
                        fw: FontWeight.w400,
                        fontSize: 8.sp,
                        borderColor: Colors.transparent,
                        bordercircular:6.r ,
                      ),
                        Row(children: [
                          CustomText(date,fw: FontWeight.w400,size: 10.sp,color: ColorConstant.whiteColor,),
                         SizedBox(width: 5.w,),
                          SizedBox(width: 5.w,),
                          CustomText(views,fw: FontWeight.w400,size: 10.sp,color: ColorConstant.whiteColor,),
                        ],)
                    ],),
                  ) ),
            ],),
          ),
          SizedBox(height: 5.r,),
          CustomText(text,fw: FontWeight.w400,size: 16.sp,color: ColorConstant.blackColor,),
          SizedBox(height: 10.r,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                CustomImage(
                  image: ImagesConstant.loginPageImage,
                  width: 24.w,
                  height: 24.h,
                  borderRadius: 4.r,
                ),
                SizedBox(width: 10.w,),
                CustomText(name,fw: FontWeight.w400,size: 10.sp,color: ColorConstant.textColor,),
              ],),
             Container(child: icon),

            ],)
        ],),
    );
  }
}
