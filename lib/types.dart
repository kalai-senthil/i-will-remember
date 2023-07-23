import 'package:flutter/material.dart';

final class NavItem {
  final String name;
  final int index;
  final String icon;
  final Widget screen;
  NavItem({
    required this.name,
    required this.icon,
    required this.index,
    required this.screen,
  });
}
