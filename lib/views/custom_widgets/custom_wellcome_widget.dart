
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomWellComeStack extends StatelessWidget {
  final String? headingText;
  final FontWeight? headingTextFw;
  final double? headingTextSize;
  final String? text;
  final double? textSize;
  final FontWeight? textFw;
  final Color? textColor;
  final String? buttonText;
  const CustomWellComeStack({super.key, this.headingText, this.text, this.textSize,  this.textColor, this.buttonText, this.headingTextFw, this.headingTextSize, this.textFw});
  @override
  Widget build(BuildContext context) {
    return Container(
child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
FittedBox(child: CustomText(headingText,fw: headingTextFw,size: headingTextSize,color: textColor,)),
FittedBox(child: CustomText(text,fw: textFw,size: textSize,color: textColor,)),
  SizedBox(height: 10.h,),
],),
);
  }
}



