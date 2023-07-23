import 'package:flutter/material.dart';
import 'package:remainder/screens/home.dart';
import 'package:remainder/screens/settings.dart';
import 'package:remainder/screens/tasks.dart';
import 'package:remainder/types.dart';
import 'dart:developer' show log;

final class StringKeys {
  static const tasksIcon = "assets/tasks.svg";
  static const homeIcon = "assets/home.svg";
  static const settingsIcon = "assets/settings.svg";
}

final class Utils {
  static final List<NavItem> navItems = [
    NavItem(
      name: "Home",
      icon: StringKeys.homeIcon,
      index: 0,
      screen: const Home(),
    ),
    NavItem(
      name: "Tasks",
      icon: StringKeys.tasksIcon,
      index: 1,
      screen: const Tasks(),
    ),
    NavItem(
      name: "Settings",
      icon: StringKeys.settingsIcon,
      index: 2,
      screen: const Settings(),
    ),
  ];
  static const primaryColor = Color(0xffb1a1ea);
  static final borderRadiusRoundedFull = BorderRadius.circular(9999);
  static const print = log;
}
