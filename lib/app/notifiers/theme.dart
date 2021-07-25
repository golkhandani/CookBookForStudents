import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipe_for_students_flutter/app/notifiers/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType { dark, light }

class Preferences {
  static Future<bool> setData(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, data);
  }

  static Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}

class GlobalTheme extends ChangeNotifier {
  // grey const Color(0xff262626)

  Color settingPageBackground = Colors.black;
  Color recipePageBackground = Colors.black;
  Color recipePageContainerBackground = Colors.white70;
  Color recipePageToolbarBackground = Colors.black;
  Color recipePageSearch = Colors.white70;

  Color textColorHight = Colors.white;
  Color textColorMedium = Colors.white70;
  Color textColorLight = Colors.white60;

  Color dockTextColor = Colors.white70;

  double blurXY = 1.0;
  Color blurSolidColor = const Color(0xff383634).withOpacity(0.8);
  Color blurColor = const Color(0xff383634).withOpacity(0.3);

  LinearGradient blurGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      Colors.black.withOpacity(0.1),
      Colors.black.withOpacity(0.8),
    ],
  );

  ImageFilter imageFilter = ImageFilter.blur(
    sigmaX: 5,
    sigmaY: 5,
    tileMode: TileMode.mirror,
  );

  // Fix
  BorderRadius borderRadius = BorderRadius.circular(15);
  BorderRadius borderRadiusCircle = BorderRadius.circular(100);

  Widget verticalGap(double size) {
    return SizedBox(height: size);
  }

  Widget horizontalGap(double size) {
    return SizedBox(width: size);
  }

  ThemeType currentTheme = ThemeType.dark;
  Future<void> loadTheme() async {
    var theme = await Preferences.getData("currentTheme");
    print(theme);
    if (theme != null) {
      theme == "Dark" ? changeThemeToDark() : changeThemeToLight();
    }
  }

  switchTheme() async {
    print(currentTheme);
    switch (currentTheme) {
      case ThemeType.light:
        changeThemeToDark();
        Preferences.setData("currentTheme", "Dark");
        break;
      case ThemeType.dark:
        changeThemeToLight();
        Preferences.setData("currentTheme", "Light");
        break;
      default:
        changeThemeToLight();
        Preferences.setData("currentTheme", "Light");
        break;
    }

    notifyListeners();
  }

  changeThemeToDark() {
    print("Change Theme to Dark");
    currentTheme = ThemeType.dark;
    settingPageBackground = Colors.black;
    recipePageBackground = Colors.black;
    recipePageContainerBackground = Colors.white70;
    recipePageToolbarBackground = Colors.black;
    recipePageSearch = Colors.white70;

    textColorHight = Colors.white;
    textColorMedium = Colors.white70;
    textColorLight = Colors.white60;

    dockTextColor = Colors.white70;

    blurXY = 1.0;
    blurSolidColor = const Color(0xff383634).withOpacity(0.8);
    blurColor = const Color(0xff383634).withOpacity(0.3);

    blurGradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        Colors.black.withOpacity(0.1),
        Colors.black.withOpacity(0.8),
      ],
    );
    print("Changed Theme to Dark $currentTheme");
  }

  changeThemeToLight() {
    print("Change Theme to Light");
    currentTheme = ThemeType.light;
    settingPageBackground = Colors.white;
    recipePageBackground = Colors.white;
    recipePageContainerBackground = Colors.black54;
    recipePageToolbarBackground = Colors.white;
    recipePageSearch = Colors.black38;

    textColorHight = Colors.black87;
    textColorMedium = Colors.black54;
    textColorLight = Colors.black45;

    dockTextColor = Colors.black;

    blurXY = 1.0;
    blurSolidColor = Color(0xffe6e6e6).withOpacity(0.8);
    blurColor = const Color(0xffe6e6e6).withOpacity(0.3);

    blurGradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        Colors.white.withOpacity(0.1),
        Colors.white.withOpacity(0.8),
      ],
    );
    print("Changed Theme to Light $currentTheme");
  }
}

final GlobalTheme appTheme = GlobalTheme();



/**
 * LIGHT
 Color recipePageBackground = Colors.orange[100]!;
  Color recipePageContainerBackground = Colors.orange[400]!;
  Color recipePageSearch = Colors.white;

  Color textColorHight = const Color(0xff262626);
  Color textColorMedium = const Color(0xff383634);
  Color textColorLight = Colors.black38;

  Color dockBackgroundColor = Colors.grey[300]!;
  Color dockTextColor = Colors.black;

  double blurXY = 1.0;
  Color blurSolidColor = Colors.white.withOpacity(0.8);
  Color blurColor = Colors.white.withOpacity(0.1);

  LinearGradient blurGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      Colors.white.withOpacity(0.1),
      Colors.white.withOpacity(0.8),
    ],
  );

  ImageFilter imageFilter = ImageFilter.blur(
    sigmaX: 5,
    sigmaY: 5,
    tileMode: TileMode.mirror,
  );

  // Fix
  BorderRadius borderRadius = BorderRadius.circular(15);
  BorderRadius borderRadiusCircle = BorderRadius.circular(100);

  Widget verticalGap(double size) {
    return SizedBox(height: size);
  }

  Widget horizontalGap(double size) {
    return SizedBox(width: size);
  }

  ThemeType currentTheme = ThemeType.light;
 */