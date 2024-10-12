import 'package:breath_in/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class FlushMessagesUtil{
  static void snackBarMessage(String headingText,String message,BuildContext context) {
    Get.snackbar(
      headingText,
      message,
      colorText: Colors.black,
      backgroundColor:ColorConstant.dimGray,
      snackPosition: SnackPosition.TOP,
    );
  }

  static void easyLoading(){
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom // Set the custom style
      ..textColor = Colors.white // Color of the loading status text
      ..indicatorColor = Colors.white // Color of the loading indicator
      ..progressColor = Colors.white // Progress color of the loading indicator (if applicable)
      ..backgroundColor = ColorConstant.dimGray // Background color of the loading indicator
      ..maskColor = Colors.red; // Mask color of the loading (if applicable)
    EasyLoading.show(status: 'Please Wait...');
  }
}
