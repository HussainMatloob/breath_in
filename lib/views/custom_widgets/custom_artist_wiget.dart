import 'dart:typed_data';
import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/controller/video_controller.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomArtistWidget extends StatefulWidget {
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
  final Uint8List?  thumbNail;
  const CustomArtistWidget({super.key, this.height, this.width, this.image, this.likeIcon, this.playIcon, this.moreVert, this.downloadIcon, this.heading, this.tracks, this.views, this.name, this.fw, this.size, this.textColor, this.borderRadius, this.onTab, this.padding, this.thumbNail});


  @override
  State<CustomArtistWidget> createState() => _CustomArtistWidgetState();

}

class _CustomArtistWidgetState extends State<CustomArtistWidget> {
 // String videoUrl = "https://drive.google.com/uc?export=view&id=1uQYXnnrwlsQTk9u9sAB4dP9L4VFGuUFX";
  VideoController videoController=Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(
      builder: (videoController)
      {
        return   GestureDetector(
          onTap: widget.onTab,
          child: Container(
            margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.all(widget.padding??0.r),
              height:widget.height,
              width: widget.width,
              decoration: BoxDecoration(color: ColorConstant.whiteColor,
                borderRadius: BorderRadius.circular(widget.borderRadius??0.r),
              ),
              child: Row(children: [
                //
                // Container(
                //   height: 46.h,
                //   width: 47.w,
                //   child: Center(
                //       child: videoController.thumbnailData != null
                //           ? ClipRRect(
                //         borderRadius: BorderRadius.circular(4.r),
                //         child: Image.memory(
                //            widget. thumbNail!,
                //           fit: BoxFit.fill,
                //           height: widget.height,
                //           width: widget.width,
                //         ),
                //       )
                //           : Center(child: CircularProgressIndicator(color: ColorConstant.buttonColor,),)  // Show a loader while generating
                //   ),),

                SizedBox(width: 10.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(widget.heading,fw: FontWeight.w400,size: 13.sp,),
                            SizedBox(width: 15.w,),
                            Container(child: widget.likeIcon),
                          ],),
                      ),

                      Expanded(
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SizedBox(width: 150.w,),
                            CustomText(widget.tracks,fw: FontWeight.w400,size: 12.sp,color: ColorConstant.dimGray,),
                            Container(child: widget.moreVert,),
                          ],),
                      ),

                    ],),
                )
              ],),
            ),
        ) ;
      }
    );
  }
}


