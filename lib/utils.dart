import 'package:flutter/material.dart';
import 'package:remainder/screens/home.dart';
import 'package:remainder/screens/settings.dart';
import 'package:remainder/types.dart';
import 'dart:developer' show log;

import 'package:remainder/ui/home_view.dart';
import 'package:remainder/ui/task_categories.dart';

final class CollectionKeys {
  static const users = "users";
  static const remainders = "remainders";
  static const todos = "todos";
  static const categories = "categories";
}

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
      name: "Settings",
      icon: StringKeys.settingsIcon,
      index: 1,
      screen: const Settings(),
    ),
  ];
  static final List<Widget> homeItems = [
    const HomwView(),
    const TaskCategories()
  ];
  static const days = ['Mon', 'Tue', "Wed", "Thu", "Fri", "Sat", "Sun"];
  static const months = [
    "",
    'January',
    'February',
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  static const lightPrimaryColor = Color(0xfff6f6fe);
  static const cardPadding = EdgeInsets.symmetric(vertical: 5, horizontal: 10);
  static const lightSecondaryColor = Color(0xff121943);
  static const lightPrimaryContainerColor = Color(0xff8871e5);
  static const darkPrimaryColor = Color(0xff6a52d8);
  static const primaryColor = Color(0xffb1a1ea);
  static const pagePadding = EdgeInsets.symmetric(horizontal: 6);
  static final borderRadiusRoundedFull = BorderRadius.circular(9999);
  static final borderRadiusRoundedCard = BorderRadius.circular(10);
  static const print = log;
  static List<BoxShadow> cardBtnShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(.04),
      blurRadius: 10,
      spreadRadius: 2,
    ),
  ];
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(.06),
      blurRadius: 10,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(.04),
      blurRadius: 10,
    ),
  ];
}
