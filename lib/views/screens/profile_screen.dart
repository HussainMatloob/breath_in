import 'package:breath_in/views/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constant.dart';
import '../custom_widgets/custom_button_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        extendBodyBehindAppBar: true,
        
        body: Container(
          padding: EdgeInsets.all(20.r),
        ) );
  }
}
