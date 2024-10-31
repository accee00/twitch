import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch/provider/user_provider.dart';
import 'package:twitch/screens/home_screen.dart';
import 'package:twitch/screens/log_in_screen.dart';
import 'package:twitch/screens/on_board.dart';
import 'package:twitch/screens/splash_screen.dart';
import 'package:twitch/utils/colors.dart';
import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: backgroundColor,
          titleTextStyle: const TextStyle(
            color: primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: const IconThemeData(
            color: primaryColor,
          ),
        ),
      ),
      routes: {
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        LogInScreen.routeName: (context) => const LogInScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
      title: "Twitch Clone",
      home: const SplashScreen(),
    );
  }
}
