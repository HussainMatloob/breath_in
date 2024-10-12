import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
        this.borderColor,
        this.boxColor,
        this.text = '',
        this.textColor,
        this.fontSize,
        this.textAlign,
        this.height,
        this.width,
        this.bordercircular,
        this.onTap,
        this.fw,
       this.borderWidth,
        this.image, this.icon,
        this.loader=false,
      });
  final Color? borderColor;
  final Color? boxColor;
  final String? text;
  final Color? textColor;
  final double? fontSize;
  final TextAlign? textAlign;
  final double? height;
  final double? width;
  final double? bordercircular;
  final VoidCallback? onTap;
  final FontWeight? fw;
  final double? borderWidth;
  final String?  image;
  final Icon? icon;
  final bool? loader;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: height??0.h,
          width: width??0.w,
          decoration: BoxDecoration(
              border: borderColor!=null?Border.all(
                  color: borderColor!,width:borderWidth??0.w,
              ):Border.all(  ),
              color: boxColor,
              borderRadius:bordercircular==null? BorderRadius.all(Radius.circular(25)):BorderRadius.all(Radius.circular(bordercircular!))),

          child: Center(
            child:image!=null ?Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(
                height: 20.h,
                width: 20.w,
                decoration: BoxDecoration(
                  image: DecorationImage(image:AssetImage(image!),
                  fit: BoxFit.fill
                  )
                ),
              ),
              SizedBox(width: 10.w,),
              CustomText(
                text!,
                fw: fw,
                size: fontSize,
                textAlign: textAlign,
                color: textColor,
              ),
            ],) : icon!=null?icon: loader==true ?CircularProgressIndicator(color: ColorConstant.whiteColor,) :CustomText(
              text!,
              fw: fw,
              size: fontSize,
              textAlign: textAlign,
              color: textColor,
            ),
          )),
    );
  }
}