import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/models/user_model.dart';
import 'package:breath_in/views/custom_widgets/custom_Image.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomChatUsers extends StatelessWidget {
  final double? height;
  final double? width;
  final String? image;
  final Icon? downloadIcon;
  final String? heading;
  final String? lastMessage;
  final String? views;
  final String? name;
  final double? fw;
  final double? size;
  final Color? textColor;
  final double? borderRadius;
  final VoidCallback? onTab;
  final double? padding;
  final UserModel?  userModel;
  const CustomChatUsers({super.key, this.height, this.width, this.image, this.downloadIcon, this.heading, this.lastMessage, this.views, this.name, this.fw, this.size, this.textColor, this.borderRadius, this.onTab, this.padding, this.userModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding??0.r),
      height: height,
      width: width,
      decoration: BoxDecoration(color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(borderRadius??0.r),
      ),
      child: Row(children: [
        CustomImage(
          image: image,
          height: 52.h,
          width: 52.w,
          borderRadius: borderRadius??100.r,
        ),
        SizedBox(width: 10.w,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(userModel!.userName,fw: FontWeight.w400,size: 16.sp,color: ColorConstant.textColor,),
                    SizedBox(width: 15.w,),
                    CustomText("12:00",fw: FontWeight.w400,size: 10.sp,color: ColorConstant.textColor),

                  ],),
              ),

              Expanded(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SizedBox(width: 150.w,),
                    CustomText(lastMessage,fw: FontWeight.w400,size: 12.sp,  color: ColorConstant.textColor,),
                    Container(
                      height: 10.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color:ColorConstant.buttonColor),
                      padding: EdgeInsets.all(5.r,),
                    )
                  ],),
              ),

            ],),
        )
      ],),
    );
  }
}
