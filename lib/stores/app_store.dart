import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:remainder/stores/login_store.dart';
import 'package:remainder/stores/nav_store.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

enum ThemeEnum { light, dark, system }

abstract class _AppStore with Store {
  _AppStore() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        isLoggedIn = false;
        navStore.setScreen(Screen.login);
        return;
      }
      isLoggedIn = true;
      this.user = user;
    });
  }

  @observable
  User? user;
  @observable
  bool isLoggedIn = false;
  @observable
  ThemeEnum theme = ThemeEnum.light;

  @action
  void setTheme(ThemeEnum themeEnum) {
    theme = theme != ThemeEnum.dark ? ThemeEnum.dark : ThemeEnum.light;
  }

  NavStore navStore = NavStore();
  LoginStore loginStore = LoginStore();
}
