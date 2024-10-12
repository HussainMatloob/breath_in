import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/views/screens/navigation_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'firebase_options.dart';
late Size mq;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        // Check if the orientation is landscape or portrait
        var isLandscape = orientation == Orientation.landscape;
        return ScreenUtilInit(
          // Set the designSize based on the screen orientation
          designSize: isLandscape ? Size(932, 430) : Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'breathIn',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: ColorConstant.whiteColor),
                useMaterial3: true,
              ),
              home:  NavigationScreen(),
              builder: EasyLoading.init(),
            );
          },
        );
      },
    );
  }
}

