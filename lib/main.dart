import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fl2_qwerty_messenger/Page/register.dart';
import 'package:fl2_qwerty_messenger/themes.dart';
import 'package:fl2_qwerty_messenger/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<API>(
      create: (_) => API(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: context.watch<API>().user.darkMode ? darkThemeData(context) : lightThemeData(context),
      home: AnimatedSplashScreen(
        splashIconSize: 200.0,
        duration: 3000,
        splash: 'assets/images/logo.png',
        nextScreen: const Register(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
