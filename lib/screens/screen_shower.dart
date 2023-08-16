import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:remainder/screens/login.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/ui/navbar.dart';
import 'package:remainder/utils.dart';

class ScreenShower extends StatelessWidget {
  const ScreenShower({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final isLoggedIn = context.read<AppStore>().isLoggedIn;
      if (!isLoggedIn) return const Login();
      return Scaffold(
        bottomNavigationBar: const NavBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<AppStore>().setTheme(ThemeEnum.dark);
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IndexedStack(
              index: context.read<AppStore>().navStore.selectedScreenIndex,
              children: Utils.navItems.map(
                (e) {
                  return e.screen;
                },
              ).toList(),
            ),
          ),
        ),
      );
    });
  }
}
