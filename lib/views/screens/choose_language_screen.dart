import 'package:breath_in/constants/color_constant.dart';
import 'package:breath_in/views/custom_widgets/custom_button_widget.dart';
import 'package:breath_in/views/screens/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/authentication_controller.dart';
import '../custom_widgets/custom_text.dart';
import '../custom_widgets/custom_text_form_field.dart';
class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});
  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}
class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  TextEditingController searchController=TextEditingController();
  AuthenticationController authenticationController=Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
      builder: (authController) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: CustomButton(
                width: 39.w,
                height: 39.h,
                bordercircular: 10.r,
                icon: Icon(Icons.arrow_back_ios_new, color: ColorConstant.blackColor, size: 20.sp),
                onTap: () {
                  Get.back();
                },
                borderColor: ColorConstant.borderColor,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.all(30.r),
            color: ColorConstant.whiteColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 110.h),
                      CustomText(
                        "Choose The Language",
                        size: 24.sp,
                        fw: FontWeight.w400,
                        color: ColorConstant.blackColor,
                      ),
                      SizedBox(height: 5.h),
                      CustomText(
                        "Please select the language, you can always change your preference in settings.",
                        size: 16.sp,
                        fw: FontWeight.w400,
                        color: ColorConstant.dimGray,
                      ),
                      SizedBox(height: 50.h),

                      // Search field for country
                      CustomTextFormField(
                        hintText: "Search",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: ColorConstant.hintTextColor),
                        borderColor: ColorConstant.borderColor,
                        controller: searchController,
                        prefixIcon: Icon(Icons.search, color: ColorConstant.iconColor),
                        onChanged: (value) {
                          authController.filterCountries(value);
                        },
                        focusedBorderColor: ColorConstant.borderColor,
                      ),

                      SizedBox(
                        height: 350.h, // Specify the height or use Expanded
                        child: ListView.builder(
                          itemCount: authController.filteredCountries.length,
                          itemBuilder: (context, index) {
                            final country = authController.filteredCountries[index];
                            return GestureDetector( // Use GestureDetector for handling taps
                              onTap: () {
                                authController.selectCountry(index); // Update selected index
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: authController.selectedIndex == index // Check if this index is selected
                                      ? Border.all(color: ColorConstant.borderColor, width: 2) // Border color and width
                                      : null,
                                  borderRadius: BorderRadius.circular(10), // Optional: to round the corners
                                ),
                                child: ListTile(
                                  leading: Text(country.flagEmoji), // Flag icon
                                  title: Text(country.name), // Country name
                                  trailing: authController.selectedIndex == index ?Container(
                                    width: 25.w,
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100.r),
                                        color: ColorConstant.grayColor
                                    ),
                                    child: Center(child: Icon(Icons.check,color: ColorConstant.whiteColor,size: 11.sp,),),
                                  ):null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  CustomButton(
                    width: 335.w,
                    height: 50.h,
                    boxColor: ColorConstant.buttonColor,
                    text: "Continue",
                    textColor: ColorConstant.blackColor,
                    fw: FontWeight.w700,
                    fontSize: 16.sp,
                    bordercircular: 10.r,
                    borderColor: Colors.transparent,
                    onTap: () {
                   Get.offAll(( )=>NavigationScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
