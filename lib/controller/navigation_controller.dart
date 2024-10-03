import 'package:breath_in/views/screens/post_screen.dart';
import 'package:breath_in/views/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/screens/home_screen.dart';

class NavigationController extends GetxController{
  int selectedNavIndex=0;

  void navIndex(index){
    selectedNavIndex=index;
    update();
  }


  final List<Widget> pages = [
    HomeScreen(),
    PostScreen(),
    ProfileScreen(),
  ];

}