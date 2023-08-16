import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:remainder/firebase_options.dart';
import 'package:remainder/screens/screen_shower.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/utils.dart';
import 'package:alarm/alarm.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
            navigatorKey: navigatorKey,
            builder: FToastBuilder(),
            title: 'Remainder',
            debugShowCheckedModeBanner: false,
            theme: theme == ThemeEnum.light
                ? ThemeData(
                    switchTheme: SwitchThemeData(
                      trackColor: MaterialStateProperty.resolveWith(
                        (states) {
                          if (states.contains(MaterialState.selected)) {
                            return Utils.primaryColor;
                          }
                        },
                      ),
                      thumbColor: MaterialStateProperty.resolveWith(
                        (states) {
                          if (states.contains(MaterialState.selected)) {
                            return Utils.lightPrimaryColor;
                          }
                        },
                      ),
                    ),
                    tabBarTheme: TabBarTheme(
                      labelStyle: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w600,
                      ),
                      labelColor: Utils.darkPrimaryColor,
                      unselectedLabelStyle: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w600,
                        color: Utils.lightSecondaryColor,
                      ),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Utils.lightSecondaryColor,
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      disabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      labelStyle: GoogleFonts.quicksand(),
                      hintStyle: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    textTheme: TextTheme(
                      labelLarge: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      bodyLarge: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                      ),
                      labelMedium: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    iconButtonTheme: IconButtonThemeData(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Utils.lightPrimaryColor,
                        ),
                        textStyle: MaterialStateProperty.all(
                          GoogleFonts.quicksand(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Utils.darkPrimaryColor,
                          ),
                          textStyle: MaterialStateProperty.all(
                            GoogleFonts.quicksand(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )),
                    ),
                    bottomNavigationBarTheme:
                        const BottomNavigationBarThemeData(
                      enableFeedback: false,
                      showSelectedLabels: false,
                      selectedIconTheme: IconThemeData(
                        color: Utils.darkPrimaryColor,
                      ),
                      elevation: 10,
                      showUnselectedLabels: false,
                      backgroundColor: Utils.lightPrimaryColor,
                    ),
                    fontFamily: "QuickSand",
                    colorScheme: const ColorScheme.light(
                      primary: Utils.lightPrimaryColor,
                      background: Colors.white,
                      onPrimaryContainer: Utils.lightPrimaryContainerColor,
                      onSecondaryContainer: Utils.primaryColor,
                      onSecondary: Utils.lightSecondaryColor,
                    ),
                    useMaterial3: true,
                  )
                : ThemeData(
                    inputDecorationTheme: InputDecorationTheme(
                      disabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      labelStyle: GoogleFonts.quicksand(
                        color: Colors.white,
                      ),
                      hintStyle: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    textTheme: TextTheme(
                      labelLarge: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      bodyLarge: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      labelMedium: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    iconButtonTheme: IconButtonThemeData(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(
                            0xffc6c9ff,
                          ),
                        ),
                        textStyle: MaterialStateProperty.all(
                          GoogleFonts.quicksand(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(
                            0xffc6c9ff,
                          ),
                        ),
                        textStyle: MaterialStateProperty.all(
                          GoogleFonts.quicksand(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    iconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    bottomNavigationBarTheme:
                        const BottomNavigationBarThemeData(
                      enableFeedback: false,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      backgroundColor: Color(
                        0xff252c54,
                      ),
                    ),
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
