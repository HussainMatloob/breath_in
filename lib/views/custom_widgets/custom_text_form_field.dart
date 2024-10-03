import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? message;
  final String? hintText;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final double? width;
  final double? height;
  final bool isPassword;
  final Color? color;
  final FocusNode? focusNode;
  final TextStyle? hintStyle;
  final bool? isPass;
  final VoidCallback? obSecureTap;
  final bool? isObSecure;
  final String? Function(String?)? validateFunction;
  final Icon? prefixIcon;
  final Function(dynamic value)? onChanged;
  final bool? isSearch;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.message,
    this.borderColor =Colors.white,
    this.focusedBorderColor = Colors.white,
    this.errorBorderColor = Colors.red,
    this.width,
    this.height,
    this.isPassword = false,
    this.color,
    this.focusNode, this.hintStyle,this.isPass =false, this.obSecureTap,this.isObSecure=false,this.validateFunction, this.prefixIcon,this.onChanged, this.isSearch=false

  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          color: widget.color??Colors.transparent,
          borderRadius: BorderRadius.circular(10.r)),
      child: TextFormField(
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        //keyboardType: TextInputType.multiline,
        //maxLines: null,
        obscureText: widget.isObSecure??false, // Toggle visibility based on state
        obscuringCharacter: "*",
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.text,
        controller: widget.controller,
        decoration: InputDecoration(
            labelText: widget.labelText,
            hintStyle: widget.hintStyle??TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: Color(0xFF9E9E9E),

            ),
            hintText: widget.hintText,
            border:widget.isSearch==true ?UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2.0.w,
              ),
            ) :OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: widget.borderColor),
            ),
            focusedBorder:widget.isSearch==true ?UnderlineInputBorder(
              borderSide: BorderSide(
                color:  widget.focusedBorderColor,
              ),
            ): OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: widget.focusedBorderColor, width: 2.0.w),
            ),
            enabledBorder:widget.isSearch==true ? UnderlineInputBorder(
              borderSide: BorderSide(
                color:  widget.focusedBorderColor,
              ),
            ): OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: widget.borderColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: widget.errorBorderColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: widget.errorBorderColor, width: 2.0.w),
            ),
            prefixIcon: widget.prefixIcon??null,
            suffixIcon: widget.obSecureTap!=null?InkWell(
                onTap: widget.obSecureTap,
                child: widget.isObSecure! ? Icon(Icons.visibility_off_outlined):Icon(Icons.remove_red_eye)
            ):null,
            fillColor: Colors.white24,
            filled: true
        ),
        validator: widget.validateFunction
      ),
    );
  }
}