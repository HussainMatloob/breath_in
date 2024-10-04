import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/Images_Constant.dart';
import '../../constants/color_constant.dart';
import '../custom_widgets/Custom_favourite_or_exercise_widgets.dart';

class ModeScreen extends StatefulWidget {
  const ModeScreen({super.key});

  @override
  State<ModeScreen> createState() => _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height:  Get.height,
      child: GridView.builder(
              shrinkWrap: true,
             physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              // physics: NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),  // Disable GridView's internal scrolling
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                childAspectRatio: 1.25,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                return CustomFavouriteorExerciceWidget(
                  heading: "Drift Off",
                  textTime: "17 mis",
                  textSleep: "Sleep",
                  height: 82.h,
                  width: 157.w,
                  borderRadius: 10.r,
                  image: ImagesConstant.localImage,
                  icon: Icon(Icons.favorite_outlined,color: ColorConstant.redColor,size: 12.sp,),
                  onTab: (){},
                );
              },
            ),
    );
  }
}
