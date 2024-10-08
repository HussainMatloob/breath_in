import 'dart:io';
import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/controller/audio_controller.dart';
import 'package:breath_in/services/firebase_services.dart';
import 'package:breath_in/utils/flush_messages.dart';
import 'package:breath_in/views/custom_widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioController>(
      init: AudioController(),
      builder: (audioController){
       return  Scaffold(
         appBar: AppBar(),
          body: Container(
            margin: EdgeInsets.all(30.r),
            child: SingleChildScrollView(
              child: Column(

                children: [
                  CustomButton(
                    height: 200.h,width: 200.w,
                    text: "Select Audio",
                    fw: FontWeight.w700,
                    fontSize: 16.sp,
                    borderColor: Colors.transparent,
                    boxColor: ColorConstant.dimGray,
                    bordercircular: 20.r,
                    onTap: () async{
                     audioController.pickAudioFile();
                    },
                  ),
                SizedBox(height: 30.h,),
                  CustomButton(
                    height: 100.h,width: 200.w,
                    text: "Add",
                    fw: FontWeight.w700,
                    fontSize: 16.sp,
                    borderColor: Colors.transparent,
                    boxColor: ColorConstant.dimGray,
                    bordercircular: 20.r,
                    onTap: () async{
                      if(audioController.Url==null){
                        FlushMessagesUtil.snackBarMessage("error", "Please select audio", context);
                      }
                      else{
                        FirebaseServices.uploadAudioToFirebase(audioController.Url as File);
                      }
                    },
                  )
                ],),
            ),
          ),
        );
      },

    );
  }
}
