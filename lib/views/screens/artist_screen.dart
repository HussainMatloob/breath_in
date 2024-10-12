import 'package:breath_in/constants/Images_Constant.dart';
import 'package:breath_in/controller/video_controller.dart';
import 'package:breath_in/models/video_model.dart';
import 'package:breath_in/services/firebase_services.dart';
import 'package:breath_in/views/custom_widgets/custom_artist_wiget.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:breath_in/views/screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:paginate_firestore_plus/paginate_firestore.dart';


class ArtistScreen extends StatefulWidget {
  const ArtistScreen({super.key});

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {


  VideoController videoController=Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return
      GetBuilder<VideoController>(
        builder: (videoController){
          return  Expanded(
            child: SizedBox(
              child: PaginateFirestore(
                itemBuilder: (context, documentSnapshot, index) {
                  VideoModel videoModel = VideoModel.fromJson(
                      documentSnapshot[index].data()
                      as Map<String, dynamic>);
                  return CustomArtistWidget(
                    width: 332.w,
                    height: 70.h,
                    padding:7.r,
                    image: ImagesConstant.localImage,
                    heading: "Yo Yo Honey Sing",
                    tracks: "30 Tracks",
                    borderRadius: 8.r,
                    likeIcon: Icon(Icons.favorite_outline,size: 20.sp,),
                    moreVert: Icon(Icons.more_vert,size: 20.sp,),
                    onTab: (){
                      Get.to(()=>PlayVideoScreen(videoModel: videoModel,));
                    },
                  );
                },
                query:FirebaseServices.getVideosFile(),
                itemBuilderType: PaginateBuilderType.listView,
                isLive: true,
                scrollDirection: Axis.vertical,
                onEmpty: Center(
                    child: CustomText("Audios not available")),
              ),
            ),
          );
        },
      );
  }
}
