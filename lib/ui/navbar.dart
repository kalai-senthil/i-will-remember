import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/stores/nav_store.dart';
import 'package:remainder/utils.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      warnWhenNoObservables: true,
      builder: (_) {
        final selectedNavIndex =
            context.read<AppStore>().navStore.selectedScreenIndex;
        return BottomNavigationBar(
          currentIndex: selectedNavIndex,
          onTap: (ind) {
            context.read<AppStore>().navStore.setScreen(
                  Screen.values.elementAt(ind),
                );
          },
          items: Utils.navItems
              .map(
                (e) => BottomNavigationBarItem(
                  tooltip: e.name,
                  icon: NavbarItem(
                    icon: e.icon,
                    selected: selectedNavIndex == e.index,
                  ),
                  label: e.name,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class NavbarItem extends HookWidget {
  const NavbarItem({super.key, required this.icon, required this.selected});
  final String icon;
  final bool selected;
  final scaleControllerDuration = const Duration(
    milliseconds: 200,
  );
  final duration = const Duration(
    milliseconds: 120,
  );
  @override
  Widget build(BuildContext context) {
    final scaleController = useAnimationController(
      initialValue: 1,
      upperBound: 1.2,
      lowerBound: 1,
      duration: scaleControllerDuration,
    );
    final selectedNavIndicator = useAnimationController(
      initialValue: 0,
      upperBound: 35,
      lowerBound: 0,
      duration: duration,
    );
    if (selected) {
      scaleController.forward();
      selectedNavIndicator.forward();
    } else {
      scaleController.reverse();
      selectedNavIndicator.reverse();
    }

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -14,
          child: AnimatedBuilder(
            animation: selectedNavIndicator,
            builder: (_, a) => Container(
              width: selectedNavIndicator.value,
              height: 3,
              decoration: BoxDecoration(
                color: const Color(
                  0xff6a52d8,
                ),
                borderRadius: Utils.borderRadiusRoundedFull,
              ),
            ),
          ),
        ),
        Observer(builder: (ctx) {
          final isDark = context.read<AppStore>().theme == ThemeEnum.dark;
          return ScaleTransition(
            scale: scaleController,
            child: SvgPicture.asset(
              icon,
              theme: SvgTheme(
                currentColor: selected
                    ? isDark
                        ? Colors.white
                        : const Color(
                            0xff6a52d8,
                          )
                    : const Color(0xff8d8fac),
              ),
            ),
          );
        }),
      ],
    );
  }
}
