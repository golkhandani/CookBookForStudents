import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:recipe_for_students_flutter/app/pages/recipe_list_page.dart';
import 'package:recipe_for_students_flutter/app/pages/setting_page.dart';

class ApplicationPage {
  ApplicationPage({
    required this.widget,
    required this.name,
    required this.path,
    required this.iconData,
    this.color,
  });

  Widget widget;
  String name;
  String path;
  IconData iconData;
  Color? color = Colors.amber;
}

final List<ApplicationPage> pages = [
  ApplicationPage(
    widget: const RecipeListPage(),
    name: "Food",
    path: 'RecipeListPage',
    iconData: FlutterIcons.food_mco,
    color: Colors.orange,
  ),
  ApplicationPage(
    widget: Container(
      color: Colors.pink[50],
    ),
    name: "Drink",
    path: 'list',
    iconData: FlutterIcons.glass_wine_mco,
    color: Colors.pink,
  ),
  ApplicationPage(
    widget: Container(
      color: Colors.purple[50],
    ),
    name: "Favourite",
    path: 'list',
    iconData: FlutterIcons.heart_mco,
    color: Colors.purple,
  ),
  ApplicationPage(
    widget: SettingPage(),
    name: "Setting",
    path: 'list',
    iconData: FlutterIcons.settings_mco,
    color: Colors.cyan,
  )
];
