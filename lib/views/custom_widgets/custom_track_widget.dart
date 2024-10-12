import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/views/custom_widgets/custom_Image.dart';
import 'package:breath_in/views/custom_widgets/custom_button_widget.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTrackWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String? image;
  final Icon? likeIcon;
  final Icon? playIcon;
  final Icon? downloadIcon;
  final String? heading;
  final String? time;
  final String? season;
  final String? views;
  final String? name;
  final double? fw;
  final double? size;
  final Color? textColor;
  final double? borderRadius;
  final VoidCallback? onTab;
  const CustomTrackWidget({super.key, this.height, this.width, this.image, this.views, this.name, this.fw, this.size, this.textColor, this.borderRadius, this.onTab, this.likeIcon, this.playIcon, this.downloadIcon, this.heading, this.time, this.season});

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
       onTap: onTab,
       child: Container(
         margin: EdgeInsets.only(bottom: 20.h),
         height: height,
         decoration: BoxDecoration(color: ColorConstant.whiteColor,
         borderRadius: BorderRadius.circular(borderRadius??0.r),
         ),
         child: Row(children: [
           CustomImage(
             image: image,
             width: 92.w,
             borderRadius: borderRadius??0.r,
           ),

           Expanded(
             child: Container(
               padding: EdgeInsets.symmetric(horizontal: 10.w),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                 Expanded(
                   child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                       CustomText(heading,fw: FontWeight.w400,size: 13.sp,),

                       Container(child: likeIcon),
                     ],),

                 ),
                 CustomText(time,fw: FontWeight.w400,size: 10.sp,color: ColorConstant.grayColor,),
                 CustomText(season,fw: FontWeight.w400,size: 10.sp,color: ColorConstant.grayColor,),
                 Expanded(
                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(),
                        Row(children: [
                          Container(child: downloadIcon,),
                          SizedBox(width: 20.w,),
                          CustomButton(
                            width: 28.w,
                            height: 28.h,
                            bordercircular: 100.r,
                            icon: Icon(Icons.play_arrow,color: ColorConstant.whiteColor,size: 18.sp,),
                            onTap: (){
                            },
                            borderColor:Colors.transparent,
                            boxColor: ColorConstant.buttonColor,
                          ),
                        ],),
                     ],),
                 ),

               ],),
             ),
           )
         ],),
       ),
     );
  }
}
