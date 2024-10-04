import 'package:breath_in/constants/Images_Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_widgets/custom_artist_wiget.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({super.key});

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  @override
  Widget build(BuildContext context) {
    return  CustomArtistWidget(
      width: 332.w,
      height: 70.h,
      padding:7.r,
      image: ImagesConstant.localImage,
      heading: "Yo Yo Honey Sing",
      tracks: "30 Tracks",
      borderRadius: 8.r,
      likeIcon: Icon(Icons.favorite_outline,size: 20.sp,),
      moreVert: Icon(Icons.more_vert,size: 20.sp,),
    );
  }
}
