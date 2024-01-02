import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyle{
  static TextStyle small(Color color){
    return TextStyle(
      fontSize: 13.h,
      fontWeight: FontWeight.w400,
      color: color,
      letterSpacing: 0.9
    );
  }
  static TextStyle medium(Color color){
    return TextStyle(
        fontSize: 16.h,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0.9
    );
  }
  static TextStyle large(Color color){
    return TextStyle(
        fontSize: 20.h,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.9
    );
  }
  static TextStyle extraLarge(Color color){
    return TextStyle(
        fontSize: 32.h,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.9
    );
  }
}