import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/controller/files_controller.dart';
import 'package:breath_in/services/firebase_services.dart';
import 'package:breath_in/utils/flush_messages.dart';
import 'package:breath_in/views/custom_widgets/custom_button_widget.dart';
import 'package:breath_in/views/custom_widgets/custom_popup.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
  @override
  final CustomPopupMenuController controller = CustomPopupMenuController();
  Widget build(BuildContext context) {
    return GetBuilder<FilesController>(
      init: FilesController(),
      builder: (fileController){
       return  Scaffold(
         appBar: AppBar(),
          body: Container(
            height: Get.height,
            width: Get.width,
            margin: EdgeInsets.all(30.r),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 200.h,),
                        Container(
                          child: CustomPopUpDialog(
                            controller: controller,
                            // icon: null,
                            width: 190.w ,
                            height: 100.h,
                            color: ColorConstant.buttonColor,
                            child: Container(
                              padding: EdgeInsets.all(18.r),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      fileController.pickImageFiles();
                                      controller.hideMenu();
                                    },
                                    child: Container(child: Column(
                                      children: [
                                        Icon(Icons.image,color: ColorConstant.whiteColor,),
                                        CustomText("photo",color: ColorConstant.whiteColor,),
                                      ],
                                    ),),),
                                  SizedBox(width: 5.h),
                                  InkWell(
                                    onTap: (){
                                      fileController.pickAudioFiles();
                                      controller.hideMenu();
                                    },
                                    child: Container(child: Column(
                                      children: [
                                        Icon(Icons.audiotrack,color: ColorConstant.whiteColor,),
                                        CustomText("audio",color: ColorConstant.whiteColor,),
                                      ],
                                    ),),
                                  ),
                                  SizedBox(width: 5.h),
                                  InkWell(
                                    onTap: (){
                                      fileController.pickVideoFiles();
                                      controller.hideMenu();
                                    },
                                    child: Container(child: Column(
                                      children: [
                                        Icon(Icons.video_camera_front_outlined,color: ColorConstant.whiteColor,),
                                        CustomText("video",color: ColorConstant.whiteColor,),
                                      ],
                                    ),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],),
                  ),
                ),
                CustomButton(
                  height: 60.h,width: 200.w,
                  text: "Add",
                  fw: FontWeight.w700,
                  fontSize: 16.sp,
                  borderColor: Colors.transparent,
                  boxColor: ColorConstant.dimGray,
                  bordercircular: 20.r,
                  onTap: () {
                    if(fileController.audioFiles==null&&fileController.videoFiles==null&&fileController.imageFiles==null){
                      FlushMessagesUtil.snackBarMessage("error", "Please select file", context);
                    }
                    else{
                      if(fileController.fileType==FileType.audio){
                        FlushMessagesUtil.easyLoading();
                        FirebaseServices.uploadFilesToFirebaseStorage(fileController.audioFiles!,"audios",FileType.audio,context).then((value){
                          EasyLoading.dismiss();
                          FlushMessagesUtil.snackBarMessage("Success", "uploaded successfully", context);
                          return true;
                        });
                      }
                      if(fileController.fileType==FileType.video){
                        FlushMessagesUtil.easyLoading();
                        FirebaseServices.uploadFilesToFirebaseStorage(fileController.videoFiles!,"videos",FileType.video,context).then((value){
                          EasyLoading.dismiss();
                          FlushMessagesUtil.snackBarMessage("Success", "uploaded successfully", context);
                          return true;
                        });
                      }
                      if(fileController.fileType==FileType.image) {
                        FlushMessagesUtil.easyLoading();
                        FirebaseServices.uploadFilesToFirebaseStorage(fileController.imageFiles!,"images",FileType.image,context).then((value){
                          EasyLoading.dismiss();
                          FlushMessagesUtil.snackBarMessage("Success", "uploaded successfully", context);
                          return true;
                        });
                      }
                    }
                  },
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
