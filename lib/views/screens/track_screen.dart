import 'package:breath_in/constants/Images_Constant.dart';
import 'package:breath_in/models/audio_file_model.dart';
import 'package:breath_in/services/firebase_services.dart';
import 'package:breath_in/views/custom_widgets/custom_track_widget.dart';
import 'package:breath_in/views/screens/audio_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../custom_widgets/custom_text.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  @override
  Widget build(BuildContext context) {
    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText("Chapter 01",fw: FontWeight.w400,size: 14.sp,),
        SizedBox(height: 10.h,),
        StreamBuilder(
          stream: FirebaseServices.getAudioFile(),
          builder: (context,snapshot){


            if(snapshot.hasData){
              final data = snapshot.data?.docs;
              if(data!=null){
                final list = data
                    .map((e) => AudioFileModel.fromJson(e.data()))
                    .toList() ??
                    [];
                return CustomTrackWidget(
                  image: ImagesConstant.loginPageImage,
                  height: 85,
                  width: 335,
                  heading: "Find peace with your anxiety",
                  time: "05 Minutes",
                  season: "01 Session",
                  likeIcon: Icon(Icons.favorite_outline,size: 20.sp,),
                  downloadIcon: Icon(Icons.download_outlined,size: 25.sp,),
                  borderRadius: 10.r,
                  onTab: (){
                    Get.to(()=>AudioPlayer(audioFile: list[0]));
                  },
                );

              }
              else{
                return Container();
              }
            }
            else{
              return Container();
            }
          },

        ),
      ],
    );
  }
}
