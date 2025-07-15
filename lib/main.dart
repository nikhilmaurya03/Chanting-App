import 'package:flutter/material.dart';
import 'package:hello_world/count_provider.dart';
import 'package:hello_world/home_screen.dart';
import 'package:hello_world/home_screen_new.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CountProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ISKON',
        // color: Colors.black,
        theme: ThemeData(
            brightness: Brightness.light,
            appBarTheme: AppBarTheme(
              //foregroundColor: Colors.black,
              color: Colors.grey[200],
            ),
            bottomAppBarTheme: BottomAppBarTheme(
              color: Colors.grey[200],
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.white,
              hoverColor: Color.fromARGB(100, 76, 76, 76),
            )),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            appBarTheme: AppBarTheme(
                color:  Colors.grey[900],
               // color: const Color.fromARGB(255, 16, 16, 15)
                ),
            bottomAppBarTheme: BottomAppBarTheme(
              color: Colors.grey[900],
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.grey[900],
              focusColor: Color.fromARGB(136, 76, 76, 76),
              // hoverColor: colo
            )),

        themeMode: _themeMode,
        home: SuperHomeScreen(
          toggleTheme: _toggleTheme,
        ),
      //  home: MyWidget(toggleTheme: _toggleTheme,),
      ),
    );
  }
}
