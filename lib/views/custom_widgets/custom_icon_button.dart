import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Icon? icon;
  final VoidCallback? onTap;
  const CustomIconButton({super.key, this.height, this.width, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: icon);
  }
}
