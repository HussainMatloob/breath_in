import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../custom_widgets/custom_button_widget.dart';
import '../custom_widgets/custom_text.dart';
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  NavigationController navigationController=Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(

      builder: (navigationController){
        return  WillPopScope(
          onWillPop: () async{
            if(navigationController.selectedNavIndex!=0){
              navigationController.navIndex(0);
              return false;
            }
            else{
              return true;
            }
          },
          child: Scaffold(
            //extendBodyBehindAppBar: true,
            appBar: AppBar(
               //elevation: 0,
               //backgroundColor: Colors.transparent,
              title:  CustomText("Breathin",fw: FontWeight.w400,size: 20,),
              actions: [
                SizedBox(width: 10.w,),
                CustomButton(
                  width: 36.w,
                  height: 36.h,
                  bordercircular: 100.r,
                  icon: Icon(Icons.notification_important_outlined,color: ColorConstant.iconColor,size: 18.sp,),
                  onTap: (){
                  },
                  borderColor:Colors.transparent,
                  boxColor: ColorConstant.dimGray,
                ),
                SizedBox(width: 10.w,),
                CustomButton(
                  boxColor: ColorConstant.dimGray,
                  width: 36.w,
                  height: 36.h,
                  bordercircular: 100.r,
                  icon: Icon(Icons.message,color: ColorConstant.iconColor,size: 18.sp,),
                  onTap: (){

                  },
                  borderColor:Colors.transparent,
                ),
                SizedBox(width: 10.w,),
              ],
            ),
            body:navigationController.pages[navigationController.selectedNavIndex],
           bottomNavigationBar: Container(
             decoration: BoxDecoration(
                 color: ColorConstant.whiteColor,
                 borderRadius: BorderRadius.only(topRight: Radius.circular(40.r),topLeft: Radius.circular(40.r))),
             child:  BottomAppBar(
                   color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Home Button
                      IconButton(
                        icon: navigationController.selectedNavIndex==0 ?Icon(
                          Icons.home,
                          color: ColorConstant.buttonColor,
                        ):Icon(Icons.home_outlined,color: ColorConstant.iconColor,),
                        onPressed: () {
                          navigationController.navIndex(0);
                        },
                      ),
                      // Microphone Button
                      IconButton(
                        icon:navigationController.selectedNavIndex==1 ?Icon(
                          Icons.schedule,
                          color: ColorConstant.buttonColor,
                        ):Icon(Icons.schedule,color: ColorConstant.iconColor,),
                        onPressed: () {
                          navigationController.navIndex(1);
                        },
                      ),
                      IconButton(

                        icon: navigationController.selectedNavIndex==2 ?Icon(
                          Icons.person,
                          color: ColorConstant.buttonColor,
                        ):Icon(Icons.person_outline,color: ColorConstant.iconColor,),
                        onPressed: () {
                          navigationController.navIndex(2);
                        },
                      ),
                    ],
                  ),
                ),
           ),
          ),
        );
      },

    );
  }
}
