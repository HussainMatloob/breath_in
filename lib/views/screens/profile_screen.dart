import 'package:breath_in/constants/Images_Constant.dart';
import 'package:breath_in/models/user_model.dart';
import 'package:breath_in/services/firebase_services.dart';
import 'package:breath_in/views/custom_widgets/custom_Image.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:breath_in/views/custom_widgets/custom_text_form_field.dart';
import 'package:breath_in/views/screens/admin_panel.dart';
import 'package:breath_in/views/screens/wellcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../constants/color_constant.dart';
import '../custom_widgets/custom_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // extendBodyBehindAppBar: true,

        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                prefixIcon: Icon(Icons.search,color: ColorConstant.dimGray,),
                isSearch: true,
                hintText: "Search here",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: ColorConstant.dimGray),
                focusedBorderColor: ColorConstant.customGreen,
              ),
              SizedBox(height: 20.h,),
              StreamBuilder(
               stream:   FirebaseServices.getCurrentUser(),
                builder: (context,snapshot){
                 if(snapshot.hasData){
                   final data = snapshot.data?.docs;
                   if(data!=null){
                     final list = data
                         .map((e) => UserModel.fromJson(e.data()))
                         .toList() ??
                         [];
                     return Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         CustomImage(
                           image: ImagesConstant.loginPageImage,
                           width: 56.w,
                           height: 56.h,
                           borderRadius: 80.r,
                         ),
                         SizedBox(width: 8.w,),
                         CustomText(list[0].userName,fw: FontWeight.w400,size: 16.sp,color: ColorConstant.blackColor,)
                       ],);
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

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.w,),
                      CustomText("General",fw: FontWeight.w400,size: 14.sp,color: ColorConstant.blackColor,),
                      SizedBox(height: 10.w,),
                    CustomListTile(
                      symmetricHorizontal: 10.w,
                      height: 48.h,
                      width: 335.w,
                      borderColor: ColorConstant.offWhite,
                      text: "My Account",
                      icon: Icon(Icons.arrow_forward_ios_rounded,color: ColorConstant.brightCyan,size: 15.sp,),
                    borderRadius: 8.r,
                    backgroundColor: ColorConstant.snowGray,
                      onTab: (){},
                    ),
                      SizedBox(height: 10.w,),
                    CustomListTile(
                      symmetricHorizontal: 10.w,
                      height: 48.h,
                      width: 335.w,
                      borderColor: ColorConstant.offWhite,
                      text: "Favourites",
                      icon: Icon(Icons.arrow_forward_ios_rounded,color: ColorConstant.brightCyan,size: 15.sp,),
                      borderRadius: 8.r,
                      backgroundColor: ColorConstant.snowGray,
                      onTab: (){},
                    ),
                      SizedBox(height: 10.w,),
                    CustomListTile(
                      symmetricHorizontal: 10.w,
                      height: 48.h,
                      width: 335.w,
                      borderColor: ColorConstant.offWhite,
                      text: "Notification",
                      icon: Icon(Icons.arrow_forward_ios_rounded,color: ColorConstant.brightCyan,size: 15.sp,),
                      borderRadius: 8.r,
                      backgroundColor: ColorConstant.snowGray,
                      onTab: (){},
                    ),
                      SizedBox(height: 10.w,),
                    CustomListTile(
                      symmetricHorizontal: 10.w,
                      height: 48.h,
                      width: 335.w,
                      borderColor: ColorConstant.offWhite,
                      text: "Subscription",
                      icon: Icon(Icons.arrow_forward_ios_rounded,color: ColorConstant.brightCyan,size: 15.sp,),
                      borderRadius: 8.r,
                      backgroundColor: ColorConstant.snowGray,
                      onTab: (){},
                    ),
                    SizedBox(height: 20.w,),
                    CustomText("Security",fw: FontWeight.w400,size: 14.sp,color: ColorConstant.blackColor,),
                    SizedBox(height: 20.w,),
                      CustomListTile(
                        symmetricHorizontal: 10.w,
                        height: 48.h,
                        width: 335.w,
                        borderColor: ColorConstant.offWhite,
                        text: "Change Password",
                        icon: Icon(Icons.arrow_forward_ios_rounded,color: ColorConstant.brightCyan,size: 15.sp,),
                        borderRadius: 8.r,
                        backgroundColor: ColorConstant.snowGray,
                        onTab: (){},
                      ),
                      SizedBox(height: 20.w,),
                      CustomText("Support",fw: FontWeight.w400,size: 14.sp,color: ColorConstant.blackColor,),
                      SizedBox(height: 20.w,),
                      CustomListTile(
                        symmetricHorizontal: 10.w,
                        height: 48.h,
                        width: 335.w,
                        borderColor: ColorConstant.offWhite,
                        text: "Feedback",
                        icon: Icon(Icons.arrow_forward_ios_rounded,color: ColorConstant.brightCyan,size: 15.sp,),
                        borderRadius: 8.r,
                        backgroundColor: ColorConstant.snowGray,
                        onTab: (){},
                      ),
                      SizedBox(height: 10.w,),
                      CustomListTile(
                        symmetricHorizontal: 10.w,
                        height: 48.h,
                        width: 335.w,
                        borderColor: ColorConstant.offWhite,
                        text: "Help",
                        icon: Icon(Icons.arrow_forward_ios_rounded,color: ColorConstant.brightCyan,size: 15.sp,),
                        borderRadius: 8.r,
                        backgroundColor: ColorConstant.snowGray,
                        onTab: (){},
                      ),
                      SizedBox(height: 10.w,),
                      CustomListTile(
                        symmetricHorizontal: 10.w,
                        height: 48.h,
                        width: 335.w,
                        borderColor: ColorConstant.offWhite,
                        text: "Term & Conditions",
                        icon: Icon(Icons.arrow_forward_ios_rounded,color: ColorConstant.brightCyan,size: 15.sp,),
                        borderRadius: 8.r,
                        backgroundColor: ColorConstant.snowGray,
                        onTab: (){},
                      ),
                      SizedBox(height: 10.w,),
                      CustomListTile(
                        symmetricHorizontal: 10.w,
                        height: 48.h,
                        width: 335.w,
                        borderColor: ColorConstant.offWhite,
                        text: "Delete Account",
                        icon: Icon(Icons.arrow_forward_ios_rounded,color: ColorConstant.brightCyan,size: 15.sp,),
                        borderRadius: 8.r,
                        backgroundColor: ColorConstant.snowGray,
                        onTab: (){},
                      ),
                      SizedBox(height: 10.w,),
                      CustomListTile(
                        symmetricHorizontal: 10.w,
                        height: 48.h,
                        width: 335.w,
                        borderColor: ColorConstant.offWhite,
                        text: "Admin",
                        icon: Icon(Icons.arrow_forward_ios_rounded,color: ColorConstant.brightCyan,size: 15.sp,),
                        borderRadius: 8.r,
                        backgroundColor: ColorConstant.snowGray,
                        onTab: (){

                          Get.to(()=> AdminPanel());
                        },
                      ),
                      SizedBox(height: 10.w,),
                      CustomListTile(
                        symmetricHorizontal: 10.w,
                        height: 48.h,
                        width: 335.w,
                        borderColor: ColorConstant.offWhite,
                        text: "LogOut",
                        icon: Icon(Icons.arrow_forward_ios_rounded,color: ColorConstant.brightCyan,size: 15.sp,),
                        borderRadius: 8.r,
                        backgroundColor: ColorConstant.snowGray,
                        onTab: (){
                          FirebaseAuth.instance.signOut();
                          GoogleSignIn().signOut();
                          Get.offAll(()=>WellComeScreen());
                        },
                      ),
                  ],),
                ),
              ),
            ],
          ),
        ) );
  }
}
