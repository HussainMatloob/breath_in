import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseController extends GetxController{
 String selectedTab="Tracks";
 Widget? screens;


 void selectTab(value){
   selectedTab=value;
   update();
}



}