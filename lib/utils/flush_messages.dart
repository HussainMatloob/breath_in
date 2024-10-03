import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FlushMessagesUtil{
  static void snackBarMessage(String headingText,String message,BuildContext context) {
    Get.snackbar(
      headingText,
      message,
      colorText: Colors.black,
      backgroundColor: Colors.white70,
      snackPosition: SnackPosition.TOP,
    );
  }}