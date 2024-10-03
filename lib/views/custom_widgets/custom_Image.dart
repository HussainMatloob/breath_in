import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImage extends StatelessWidget {
  final double? height;
  final double? width;
  final String? image;
  final Icon? icon;
  final String? text;
  final double? fw;
  final double? size;
  final Color? textColor;
  final VoidCallback? onTab;
  final double? borderRadius;
  const CustomImage({super.key, this.height, this.width, this.image, this.icon, this.text, this.fw, this.size, this.textColor, this.onTab, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child:
        InkWell(
          onTap: onTab,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius??0.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius ?? 0.r), // Clip the image with same radius
                child: Image.asset(
                  height: height,
                  width: width,
                  image ?? "",  // Fallback to empty string if no image is provided
                  fit: BoxFit.cover, // Ensure the image covers the container fully
                ),
              )
          ),
        ),
    );
  }
}
