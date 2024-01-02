import 'package:flutter/material.dart';
import 'package:naqshrevision/src/utils/cache.dart';

class AppColor{
  static const Color red = Color(0xFFFF450B);
  static const Color primary = Color(0xFF37474F);
  static  Color grey = const Color(0xFF9D9D9D).withOpacity(0.2);
  static  Color green =  const Color(0xFF01AC6A);
  static  Color black = ThemePreferences.getDarkMode()?const Color(0xFFFFFFFF):const Color(0xFF000000);
  static  Color white = ThemePreferences.getDarkMode()?const Color(0xFF000000):const Color(0xFFFFFFFF);
  static  Color card = ThemePreferences.getDarkMode()?const Color(0xFF2d2d2d):const Color(0xFFFFFFFF);
  static  Color background = ThemePreferences.getDarkMode()?const Color(0xFF181818):const Color(0xFFFAF9F6);
  static  Color shimmerBase = ThemePreferences.getDarkMode()?const Color(0xFF2d2d2d):const Color(0xFFE5E5E5);
  static  Color shimmerHighlight = ThemePreferences.getDarkMode()?const Color(0xFF000000):const Color(0xFFFCF9F9);


  static void changeTheme(){
    background = ThemePreferences.getDarkMode()?const Color(0xFF181818):const Color(0xFFFAF9F6);
    black = ThemePreferences.getDarkMode()?const Color(0xFFFFFFFF):const Color(0xFF000000);
    white = ThemePreferences.getDarkMode()?const Color(0xFF000000):const Color(0xFFFFFFFF);
    card = ThemePreferences.getDarkMode()?const Color(0xFF2d2d2d):const Color(0xFFFFFFFF);
    shimmerBase = ThemePreferences.getDarkMode()?const Color(0xFF2d2d2d):const Color(0xFFE5E5E5);
    shimmerHighlight = ThemePreferences.getDarkMode()?const Color(0xFF000000):const Color(0xFFFCF9F9);
  }
}