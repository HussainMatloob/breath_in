import 'package:breath_in/constants/Images_Constant.dart';
import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/controller/messages_contrller.dart';
import 'package:breath_in/views/custom_widgets/receiver_voice_widget.dart';
import 'package:breath_in/views/custom_widgets/sender_voice_widget.dart';
import 'package:breath_in/models/messages_model.dart';
import 'package:breath_in/models/user_model.dart';
import 'package:breath_in/services/firebase_services.dart';
import 'package:breath_in/views/custom_widgets/custom_Image.dart';
import 'package:breath_in/views/custom_widgets/custom_button_widget.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:breath_in/views/custom_widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

import '../../main.dart';

class MessagesScreen extends StatefulWidget {
  final UserModel? userModel;
  const MessagesScreen({super.key, this.userModel});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  MessagesController messagesController = Get.put(MessagesController());
  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GetBuilder<MessagesController>(
      builder: (messagesController) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: CustomText(
                widget.userModel!.userName,
                fw: FontWeight.w400,
                size: 16.sp,
                color: Colors.black,
              ),
              leading: Padding(
                padding: EdgeInsets.all(12.r),
                child: CustomButton(
                  width: 39.w,
                  height: 39.h,
                  bordercircular: 10.r,
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: ColorConstant.blackColor,
                    size: 20.sp,
                  ),
                  onTap: () {
                    Get.back();
                  },
                  borderColor: ColorConstant.borderColor,
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                PopupMenuButton<int>(
                  icon: Icon(Icons.more_vert,
                      color: Colors.black), // Replace with your color
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        leading: CustomText(
                          "Report",
                          fw: FontWeight.w400,
                          size: 12.sp,
                          color: ColorConstant.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 5.w,
                ),
              ],
            ),
            body: Column(children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: PaginateFirestore(
                    itemBuilder: (context, documentSnapshot, index) {
                      MessagesModel messagesModel = MessagesModel.fromJson(
                          documentSnapshot[index].data()
                              as Map<String, dynamic>);
                      if (messagesModel.senderId ==
                          FirebaseAuth.instance.currentUser!.uid) {
                        if(messagesModel.messageType=="voice"){
                          return SenderVoiceWidget(messagesModel: messagesModel,);
                        }else{
                          return senderMessage(messagesModel.message!);
                        }

                      } else {
                        if(messagesModel.messageType=="voice"){
                          return ReceiverVoiceWidget(messagesModel: messagesModel,);
                        }else{
                          return receiverMessage(messagesModel.message!);
                        }

                      }
                    },
                    query: FirebaseServices.getMessages(widget.userModel!),
                    itemBuilderType: PaginateBuilderType.listView,
                    isLive: true,
                    reverse: true,
                    scrollDirection: Axis.vertical,
                    onEmpty: Center(
                        child: CustomText(
                      "Say Hii 👋!",
                      size: 20.sp,
                    )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: mq.height * .01, horizontal: mq.width * .025),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                height: 50.h,
                                borderRadius: 100.r,
                                controller: messageController,
                                color: Colors.transparent,
                                borderColor: Colors.transparent,
                                focusedBorderColor: Colors.transparent,
                                hintText: "Send a message",
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                // Initialize the recorder if not already done
                                await messagesController.initRecorder();

                                // Toggle recording state
                                if (!messagesController.isRecording) {
                                  // Start recording
                                  messagesController.startRecording();
                                } else {
                                  // Stop recording
                                  messagesController.stopRecording();

                                  // Upload the recorded voice message
                                  if (messagesController.filePath != null) {
                                    await  FirebaseServices.uploadVoiceMessage(
                                        widget.userModel!, messagesController.filePath!);
                                  }
                                }
                              },
                              child: Icon(
                                messagesController.isRecording
                                    ? Icons.stop
                                    : Icons.mic,
                                color: ColorConstant.blackColor,
                              ),
                            ),
                            SizedBox(width: 5.w),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    CustomButton(
                      borderColor: Colors.transparent,
                      height: 38.h,
                      width: 38.w,
                      boxColor: ColorConstant.buttonColor,
                      icon: Icon(Icons.send, color: ColorConstant.whiteColor),
                      onTap: () {
                        if (messageController.text.trim().isNotEmpty) {
                          FirebaseServices.sendMessage(
                              widget.userModel!, messageController.text,"text");
                          messageController.clear();
                        }
                      },
                    ),
                  ],
                ),
              )
            ]),
          ),
        );
      },
    );
  }

  Widget receiverMessage(String message) {
    return Row(
      children: [
        CustomImage(
          height: 36.h,
          width: 36.w,
          borderRadius: 16.r,
          image: ImagesConstant.loginPageImage,
        ),
        SizedBox(
          width: 18.w,
        ),
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
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(18.r),
                          bottomLeft: Radius.circular(18.r),
                          bottomRight: Radius.circular(18.r))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                          child: CustomText(
                        "${message}",
                        color: ColorConstant.whiteColor,
                        size: 13.sp,
                        fw: FontWeight.w400,
                      )),
                    ],
                  )),
              SizedBox(
                height: 10.w,
              ),
              CustomText(
                "12:00 Am",
                color: ColorConstant.blackColor,
                size: 11.sp,
                fw: FontWeight.w400,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget senderMessage(String message) {
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
                      Flexible(
                          child: CustomText(
                        "${message}",
                        color: ColorConstant.whiteColor,
                        size: 13.sp,
                        fw: FontWeight.w400,
                      )),
                    ],
                  )),
              SizedBox(
                height: 10.w,
              ),
              CustomText(
                "12:00 Am",
                color: ColorConstant.blackColor,
                size: 11.sp,
                fw: FontWeight.w400,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 18.w,
        ),
        CustomImage(
          height: 36.h,
          width: 36.w,
          borderRadius: 16.r,
          image: ImagesConstant.loginPageImage,
        ),
      ],
    );
  }

  // Widget voiceMessage(String message){
  //   Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(20),
  //       color: Colors.grey.shade200, // Style the container
  //     ),
  //     child: Row(
  //       children: [
  //         // Play / Pause Button
  //         IconButton(
  //           icon: Icon(
  //             isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
  //             size: 30,
  //             color: Colors.blue,
  //           ),
  //           onPressed: isPlaying ? _pause : _play,
  //         ),
  //         // Audio Progress
  //         Expanded(
  //           child: Slider(
  //             min: 0,
  //             max: duration.inSeconds.toDouble(),
  //             value: position.inSeconds.toDouble(),
  //             onChanged: (value) async {
  //               final newPosition = Duration(seconds: value.toInt());
  //               await _audioPlayer.seek(newPosition);
  //             },
  //           ),
  //         ),
  //         // Current Time and Total Duration
  //         Text(
  //           '${_formatDuration(position)} / ${_formatDuration(duration)}',
  //           style: TextStyle(fontSize: 14, color: Colors.black54),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
