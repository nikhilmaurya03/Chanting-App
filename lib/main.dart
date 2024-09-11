import 'package:flutter/material.dart';
import 'package:hello_world/count_provider.dart';
import 'package:hello_world/home_screen.dart';
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
              color: Colors.orange,
            ),
            bottomAppBarTheme: BottomAppBarTheme(
              color: Colors.orange,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.orange,
              hoverColor: Color.fromARGB(100, 76, 76, 76),
            )),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            appBarTheme: AppBarTheme(
                color: const Color.fromARGB(255, 91, 85, 85),
               // color: const Color.fromARGB(255, 16, 16, 15)
                ),
            bottomAppBarTheme: BottomAppBarTheme(
              color: Color.fromARGB(255, 91, 85, 85),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Color.fromARGB(255, 91, 85, 85),
              focusColor: Color.fromARGB(136, 76, 76, 76),
              // hoverColor: colo
            )),

        themeMode: _themeMode,
        home: SuperHomeScreen(
          toggleTheme: _toggleTheme,
        ),
      ),
    );
  }
}
