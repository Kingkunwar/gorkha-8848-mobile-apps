import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/core/constants/app_colors.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.primaryColor,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryColor,
    onPrimary: AppColors.primaryColor,
    secondary: Colors.white,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.red,
    background: Colors.white,
    onBackground: Colors.white,
    surface: Colors.white,
    onSurface: AppColors.primaryColor,
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(AppColors.primaryColor),
    checkColor: MaterialStateProperty.all(Colors.white),
  ),
  dividerTheme: DividerThemeData(color: Colors.grey.withOpacity(0.5)),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(AppColors.primaryColor),
  ),
  cardColor: Colors.white,
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
    trackColor: MaterialStateProperty.all(
      const Color.fromRGBO(35, 116, 225, 0.2),
    ),
  ),
  splashColor: AppColors.primaryColor,
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
      textStyle: MaterialStateProperty.all(
        TextStyle(color: Colors.white, fontSize: 18.sp),
      ),
      overlayColor: MaterialStateProperty.all(Colors.white),
    ),
  ),
  tabBarTheme: const TabBarThemeData(
    labelColor: AppColors.textColor,
    unselectedLabelColor: AppColors.textColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0XFFFBFBFB),
    systemOverlayStyle: Platform.isIOS
        ? SystemUiOverlayStyle.dark
        : const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20.sp),
    iconTheme: const IconThemeData(color: AppColors.textColor),
    actionsIconTheme: const IconThemeData(color: AppColors.textColor),
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: 14.sp,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    subtitleTextStyle: TextStyle(
      fontSize: 12.sp,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    iconColor: AppColors.textColor,
  ),
  hintColor: Colors.grey,
  iconTheme: const IconThemeData(color: Colors.grey),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.all(AppColors.textColor),
    ),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 18.sp,
      color: AppColors.textColor,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: TextStyle(
      fontSize: 24.sp,
      color: AppColors.textColor,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontSize: 22.sp,
      color: AppColors.textColor,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
    ),
    titleSmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.textColor,
    ),
    titleMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.textColor,
    ),
    displayLarge: TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.textColor,
    ),
    displayMedium: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.textColor,
    ),
    displaySmall: TextStyle(
      fontSize: 21.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.textColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 14.5.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.textColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.textColor,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.textColor,
      fontSize: 12.sp,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: AppColors.primaryColor,
  ),
);
