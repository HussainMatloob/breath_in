import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/views/custom_widgets/custom_Image.dart';
import 'package:breath_in/views/custom_widgets/custom_button_widget.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomArtistWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String? image;
  final Icon? likeIcon;
  final Icon? playIcon;
  final Icon? moreVert;
  final Icon? downloadIcon;
  final String? heading;
  final String? tracks;
  final String? views;
  final String? name;
  final double? fw;
  final double? size;
  final Color? textColor;
  final double? borderRadius;
  final VoidCallback? onTab;
  final double? padding;
  const CustomArtistWidget({super.key, this.height, this.width, this.image, this.likeIcon, this.playIcon, this.downloadIcon, this.heading,  this.views, this.name, this.fw, this.size, this.textColor, this.borderRadius, this.onTab, this.tracks, this.padding, this.moreVert});

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
          height: 46.h,
          width: 47.w,
          borderRadius: borderRadius??0.r,
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
                    CustomText(heading,fw: FontWeight.w400,size: 13.sp,),
                    SizedBox(width: 15.w,),
                    Container(child: likeIcon),
                  ],),
              ),

              Expanded(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   // SizedBox(width: 150.w,),
                    CustomText(tracks,fw: FontWeight.w400,size: 12.sp,color: ColorConstant.dimGray,),
                    Container(child: moreVert,),
                  ],),
              ),

            ],),
        )
      ],),
    );
  }
}
