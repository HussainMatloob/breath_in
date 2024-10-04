import 'package:breath_in/constants/Images_Constant.dart';
import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/models/user_model.dart';
import 'package:breath_in/views/custom_widgets/custom_Image.dart';
import 'package:breath_in/views/custom_widgets/custom_button_widget.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:breath_in/views/custom_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatefulWidget {
  final UserModel? userModel;
  const MessagesScreen({super.key, this.userModel});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(widget.userModel!.userName,fw: FontWeight.w400,size: 16.sp,color: Colors.black,),
        leading: Padding(
          padding: EdgeInsets.all(12.r),
          child: CustomButton(
            width: 39.w,
            height: 39.h,
            bordercircular: 10.r,
            icon: Icon(Icons.arrow_back_ios_new,color: ColorConstant.blackColor,size: 20.sp,),
            onTap: (){
              Get.back();
            },
            borderColor:ColorConstant.borderColor,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,

        actions: [

          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert, color: Colors.black), // Replace with your color
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading:  CustomText("Report",fw: FontWeight.w400,size: 12.sp,color: ColorConstant.blackColor,),
                ),
              ),
            ],
          ),
          SizedBox(width: 5.w,),
        ],

      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  receiverMessage(),
                  senderMessage(),
                  receiverMessage(),
                  senderMessage(),
                  receiverMessage(),
                  senderMessage()
                ],),
              ),
            ),

            SizedBox(height: 10.h,),
            Row(
              children: [
                  Expanded(child: CustomTextFormField(
                    borderRadius: 100.r,

                    color: ColorConstant.lightGry,
                    borderColor: Colors.transparent,
                    hintText: "Send a message",),
                  ),

                SizedBox(width:5.w ,),
                CustomButton(
                  borderColor: Colors.transparent,
                  height: 38.h,
                  width: 38.w,
                  boxColor: ColorConstant.buttonColor,
                  icon:  Icon(Icons.send,color: ColorConstant.whiteColor,),
                )
              ],

            ),
            SizedBox(height: 8.h,)
          ],
        ),
      ),
    );
  }

  Widget receiverMessage(){
    return Row(children: [
      CustomImage(
        height: 36.h,
        width: 36.w,
        borderRadius: 16.r,
        image: ImagesConstant.loginPageImage,

      ),
      SizedBox(width: 18.w,),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 169,
                padding: EdgeInsets.all(15.r),
                margin: EdgeInsets.only(top: 60.h),
                decoration: BoxDecoration(
                    color: ColorConstant.iconColor,

                    borderRadius: BorderRadius.only(topRight:Radius.circular(18.r) ,bottomLeft:Radius.circular(18.r) ,bottomRight:Radius.circular(18.r) )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(child: CustomText("hy",color: ColorConstant.whiteColor,size: 13.sp,fw: FontWeight.w400,)),
                  ],)
            ),
            SizedBox(height: 10.w,),
            CustomText("12:00 Am",color: ColorConstant.whiteColor,size: 11.sp,fw: FontWeight.w400,),
          ],),
      )
    ],);
  }

  Widget senderMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  width: 169,
                  margin: EdgeInsets.only(top: 60.h),

                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                      color: ColorConstant.iconColor,

                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.r),
                          bottomLeft: Radius.circular(18.r),
                          bottomRight: Radius.circular(18.r))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(child: CustomText(
                        "hi sdaljs ld;sakd asd;salkd;as sjd sl,d;lsad sdsa;lmdsa;md sdmasmdl",
                        color: ColorConstant.whiteColor,
                        size: 13.sp,
                        fw: FontWeight.w400,)),
                    ],)
              ),

              SizedBox(height: 10.w,),
              CustomText("12:00 Am", color: ColorConstant.whiteColor,
                size: 11.sp,
                fw: FontWeight.w400,),
            ],),
        ),
        SizedBox(width: 18.w,),
        CustomImage(
          height: 36.h,
          width: 36.w,
          borderRadius: 16.r,
          image: ImagesConstant.loginPageImage,

        ),
      ],);
  }
}
