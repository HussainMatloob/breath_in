 import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  final double? height;
  final double? width;
  final String? image;
  final Icon? icon;
  final String? text;
  final double? fw;
  final double? size;
  final Color? textColor;
  final double? borderRadius;
  final Color? borderColor;
  final VoidCallback? onTab;
  final double? symmetricHorizontal;
  final Color? backgroundColor;

   const CustomListTile({super.key, this.height, this.width, this.image, this.icon, this.text, this.fw, this.size, this.textColor, this.borderRadius, this.borderColor, this.onTab, this.symmetricHorizontal, this.backgroundColor});

   @override
   Widget build(BuildContext context) {
     return  GestureDetector(
       onTap: onTab,
       child: Container(
         decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(borderRadius??0.r),
             border: Border.all(color: borderColor??Colors.transparent)),
         padding: EdgeInsets.symmetric(horizontal: symmetricHorizontal??0.w),
         height: height,
         width: width,
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
           CustomText(text,fw: FontWeight.w400,size: 14.sp,color: ColorConstant.textColor,),
             Container(
               width: 24.w,
               height: 24.h,
               decoration: BoxDecoration(
                   color: ColorConstant.softPink,
                   borderRadius: BorderRadius.circular(100.r)),
               child: Center(child: icon,),),
         ],),
       ),
     );
   }
 }

