import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:remainder/stores/nav_store.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

enum ThemeEnum { light, dark, system }

abstract class _AppStore with Store {
  @observable
  bool isLoggedIn = true;
  @observable
  ThemeEnum theme = ThemeEnum.light;

  @action
  void setTheme(ThemeEnum themeEnum) {
    theme = theme != ThemeEnum.dark ? ThemeEnum.dark : ThemeEnum.light;
  }

  NavStore navStore = NavStore();
}
