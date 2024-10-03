import 'package:breath_in/constants/Images_Constant.dart';
import 'package:breath_in/views/custom_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constant.dart';
import '../custom_widgets/custom_button_widget.dart';
import '../custom_widgets/custom_post_widget.dart';
import '../custom_widgets/custom_text.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // extendBodyBehindAppBar: true,

        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            children: [
              CustomTextFormField(
                prefixIcon: Icon(Icons.search,color: ColorConstant.dimGray,),
                isSearch: true,
                hintText: "Search here",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: ColorConstant.dimGray),
                focusedBorderColor: ColorConstant.customGreen,
              ),
              SizedBox(height: 20.h,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    for(int i=0;i<9;i++)
                    CustomPostWidget(
                      image: ImagesConstant.localImage,
                      height: 164.h,
                      width: 335.w,
                      borderRadius: 12.r,
                      date: "Aug 1,2021",
                      views: "3432 views",
                      text: "How do we control our sleep and be happy in our fives 10 secret tips!",
                      icon: Icon(Icons.share,color: ColorConstant.iconColor,),
                      name: "By:muhammad Ali",
                      onTab: (){

                      },
                    ),
                  ],),
                ),
              ),
            ],
          ),
        ) );
  }
}
