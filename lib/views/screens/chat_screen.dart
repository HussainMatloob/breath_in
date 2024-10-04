import 'package:breath_in/constants/Images_Constant.dart';
import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/models/user_model.dart';
import 'package:breath_in/services/firebase_services.dart';
import 'package:breath_in/views/custom_widgets/custom_button_widget.dart';
import 'package:breath_in/views/custom_widgets/custom_chat_users.dart';
import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:breath_in/views/custom_widgets/custom_text_form_field.dart';
import 'package:breath_in/views/screens/messages_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText("Chats",fw: FontWeight.w400,size: 16.sp,color: Colors.black,),
        leading: Padding(
          padding: EdgeInsets.all(12.r),
          child: CustomButton(
            width: 39.w,
            height: 39.h,
            bordercircular: 10.r,
            icon: Icon(Icons.arrow_back_ios_new,color: ColorConstant.blackColor,size: 20.sp,),
            onTap: (){
              Get.back();
            },
            borderColor:ColorConstant.borderColor,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,

      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: Column(
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


                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseServices.getAllUsers(),
                      builder: (context,snapshot){

                        if(snapshot.hasData){
                          final data = snapshot.data?.docs;
                          if(data!=null){
                            final list = data
                                .map((e) => UserModel.fromJson(e.data()))
                                .toList() ??
                                [];
                            return ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (BuildContext context,index)
                              {
                               return CustomChatUsers(
                                  height: 100.h,
                                  padding: 10.r,
                                  image: ImagesConstant.loginPageImage,
                                  lastMessage: "Liksj djl",
                                 userModel:list[index],
                                 onTab: (){
                                    Get.to(( )=>MessagesScreen(userModel:list[index],));
                                 },
                                );
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
                  ),

                ],

        ),
      ),
    );
  }
}
