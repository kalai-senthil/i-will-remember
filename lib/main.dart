import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:remainder/screens/screen_shower.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/stores/nav_store.dart';
import 'package:remainder/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => AppStore(),
        )
      ],
      child: Observer(
        builder: (context) {
          final theme = context.read<AppStore>().theme;
          return MaterialApp(
            title: 'Remainder',
            debugShowCheckedModeBanner: false,
            theme: theme == ThemeEnum.light
                ? ThemeData(
                    bottomNavigationBarTheme:
                        const BottomNavigationBarThemeData(
                      enableFeedback: false,
                      showSelectedLabels: false,
                      selectedIconTheme: IconThemeData(
                        color: Color(
                          0xff6a52d8,
                        ),
                      ),
                      elevation: 10,
                      showUnselectedLabels: false,
                      backgroundColor: Color(
                        0xfff6f6fe,
                      ),
                    ),
                    fontFamily: "QuickSand",
                    colorScheme: const ColorScheme.light(
                      primary: Color(
                        0xfff6f6fe,
                      ),
                      background: Colors.white,
                      onPrimaryContainer: Color(0xff8871e5),
                      onSecondaryContainer: Utils.primaryColor,
                      onSecondary: Color(0xff121943),
                    ),
                    useMaterial3: true,
                  )
                : ThemeData(
                    bottomNavigationBarTheme:
                        const BottomNavigationBarThemeData(
                      enableFeedback: false,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      backgroundColor: Color(
                        0xff252c54,
                      ),
                    ),
                    textTheme: TextTheme(),
                    fontFamily: "QuickSand",
                    colorScheme: const ColorScheme.dark(
                      primary: Color(
                        0xff5d5a9c,
                      ),
                      background: Color(0xff131a44),
                      onPrimaryContainer: Colors.white,
                      onSecondaryContainer: Utils.primaryColor,
                      onSecondary: Color(0xff121943),
                    ),
                    useMaterial3: true,
                  ),
            home: const ScreenShower(),
          );
        },
      ),
    );
  }
}
