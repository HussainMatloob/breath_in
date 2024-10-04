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
                borderRadius: BorderRadius.circular(borderRadius ?? 0.r), // Clip the image with border radius
                child: image != null
                    ? Image.asset(
                  image!, // Image path
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // If error occurs, show fallback icon
                    return Icon(
                      Icons.broken_image, // Replace with your desired icon
                      size: width ?? 50, // Set the icon size to match image container
                      color: Colors.grey,
                    );
                  },
                )
                    : Icon(
                  Icons.image_not_supported, // Icon when image is null or empty
                  size: width ?? 50.w, // Set the icon size to match image container
                  color: Colors.grey,
                ),
              )
          ),
        ),
    );
  }
}
