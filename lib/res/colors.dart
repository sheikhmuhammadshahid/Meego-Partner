import 'package:flutter/material.dart';

abstract class GradientColors {
  static const primary = [
    Color(0xFF822FA3),
    Color(0xFFEF5984),
    Color(0xFFFF3F5C)
  ];
}

abstract class AppColors {
  static const primary = Color(0xFF501464);
  static const dotColor = Color(0xFFF587A0);
  static const background = Color(0xFFFAFAFF);
  static const circleAvatarColor = Color(0xFF7D7D96);
  static const colorOnPrimary = Color(0xFFFFFFFF);
  static const secondary = Color(0xFFFAFAFF);
  static const secondaryVariant = Color(0xFFC4C4C4);
  static const colorOnSecondary = Color(0xFFFFFFFF);
  static const surface = Color(0xFFFFFFFF);
  static const colorOnSurface = Color(0xFF000000);
  static const unselectedTab = Color(0xFF878787);
  static const darkGrey = Color(0xFF939393);
  static const greyLight = Color(0xFFF1F1F1);
  static const greyMidLight = Color(0xFFE5E5E5);
  static const greyBackground = Color(0xFFFBFBFB);
  static const shadowLight = Color(0x1F000000);
  static const translucentBlack = Color(0xCC000000);
  static const darkGreyVariant = Color(0xFF5C5959);
  static const darkGreyFrameBox = Color(0xFF353030);
  static const lightGreyFrameBox = Color(0xFF878787);
  static const lightGrey = Color(0xFFBBBBBB);
  static const lightRed = Color(0xFFFF949B);
  static const darkRed = Color(0xFFD60A0A);
  static const darkOrange = Color(0xFFFC8506);
  static const darkYellow = Color(0xFFF3DB07);
  static const lightGreen = Color(0xFF79D252);
  static const darkGreen = Color(0xFF43CE0F);
  static const switchGreen = Color(0xFF36E28F);
  static const loaderBackground = Color(0xFF1F1A1A);
  static const disabledRed = Color(0xFFFFDEDE);
}

abstract class Gradients {
  static const darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
    colors: [AppColors.surface, Colors.transparent],
  );
}
