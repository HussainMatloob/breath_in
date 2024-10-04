import 'package:breath_in/constants/Images_Constant.dart';
import 'package:breath_in/controller/audio_controller.dart';
import 'package:breath_in/models/audio_file_model.dart';
import 'package:breath_in/views/custom_widgets/custom_Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/color_constant.dart';
import '../custom_widgets/custom_button_widget.dart';
import 'package:audioplayers/audioplayers.dart';


class AudioPlayer extends StatefulWidget {
  AudioFileModel? audioFile;
    AudioPlayer({super.key,this.audioFile});

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  final AudioController audioController=Get.put(AudioController());
  void initState() {
    super.initState();
    if (widget.audioFile != null) {
      audioController.play(widget.audioFile!.audioFile!); // Play the audio file when screen loads
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
        actions: [
          SizedBox(width: 10.w),
          CustomButton(
            width: 36.w,
            height: 36.h,
            bordercircular: 100.r,
            icon: Icon(
              Icons.logout,
              color: ColorConstant.iconColor,
              size: 18.sp,
            ),
            onTap: () {
              // Add logic for logout or any action
            },
            borderColor: Colors.transparent,
            boxColor: ColorConstant.dimGray,
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Stack(
        children: [
          CustomImage(
            height: Get.height,
            width: Get.width,
            image: ImagesConstant.audioImage,
          ),
          Column(
            children: [
              SizedBox(height: 100.h),
              Center(
                child: CustomImage(
                  height: 285.h,
                  width: 281.w,
                  image: ImagesConstant.audioStack,
                  borderRadius: 100.r,
                ),
              ),
              SizedBox(height: 180.h),
              Obx(() {
                // Slider and control buttons are wrapped in Obx to observe the changes in the controller
                return Container(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    children: [
                      // Slider for controlling and displaying audio progress
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 3.h, // Set the track height
                          activeTrackColor: ColorConstant.buttonColor, // Active track color
                          inactiveTrackColor: Colors.grey, // Inactive track color
                          thumbColor: ColorConstant.buttonColor, // Thumb color
                          overlayColor: ColorConstant.buttonColor.withOpacity(0.2), // Overlay color
                          valueIndicatorColor: ColorConstant.buttonColor, // Value indicator color
                        ),
                        child: Slider(
                          value: audioController.position.value.inSeconds.toDouble(),
                          min: 0.0,
                          max: audioController.duration.value.inSeconds.toDouble() > 0
                              ? audioController.duration.value.inSeconds.toDouble()
                              : 1.0, // Prevent division by 0
                          onChanged: (value) {
                            audioController.seek(value); // Update the seek behavior
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Skip previous button
                          IconButton(
                            icon: Icon(Icons.skip_previous, color: ColorConstant.buttonColor, size: 30.sp),
                            onPressed: () {
                              // Implement skip previous logic
                            },
                          ),
                          SizedBox(width: 20.w),
                          // Play/Pause button (observing the player state)
                          CustomButton(
                            height: 53.h,
                            width: 53.w,
                            bordercircular: 30.r,
                            borderColor: Colors.transparent,
                            boxColor: ColorConstant.whiteColor,
                            icon: Icon(
                              audioController.playerState.value == PlayerState.playing
                                  ? Icons.pause
                                  : Icons.play_arrow, // Change icon based on state
                              color: ColorConstant.buttonColor,
                              size: 30.sp,
                            ),
                            onTap: () async {
                              if (audioController.playerState.value == PlayerState.playing) {
                                audioController.pause();
                              } else {
                                await audioController.play(widget.audioFile!.audioFile!); // Use the storage URL
                              }
                            },
                          ),
                          SizedBox(width: 20.w),
                          // Skip next button
                          IconButton(
                            icon: Icon(Icons.skip_next, color: ColorConstant.buttonColor, size: 30.sp),
                            onPressed: () {
                              // Implement skip next logic
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
