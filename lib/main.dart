import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch/models/user.dart';
import 'package:twitch/provider/user_provider.dart';
import 'package:twitch/screens/home_screen.dart';
import 'package:twitch/screens/log_in_screen.dart';
import 'package:twitch/screens/on_board.dart';
import 'package:twitch/screens/splash_screen.dart';
import 'package:twitch/utils/colors.dart';
import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }

          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(snapshot.data!.uid)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }

                if (userSnapshot.hasData && userSnapshot.data != null) {
                  final userData =
                      userSnapshot.data!.data() as Map<String, dynamic>;
                  final user = Users(
                    uid: snapshot.data!.uid,
                    username: userData['username'] ?? '',
                    email: userData['email'] ?? '',
                  );

                  Provider.of<UserProvider>(context, listen: false)
                      .setUser(user);
                  return const HomeScreen();
                }

                return const OnBoardingScreen();
              },
            );
          }

          return const SplashScreen();
        },
      ),
      // home: FutureBuilder(
      //   future: AuthMethod().getCurrentUser(
      //     FirebaseAuth.instance.currentUser?.uid,
      //   ),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(
      //           color: primaryColor,
      //         ),
      //       );
      //     }

      //     if (snapshot.hasData && snapshot.data != null) {
      //       final userData = snapshot.data!;
      //       final user = Users(
      //         uid: userData['uid'] ?? '',
      //         username: userData['username'] ?? '',
      //         email: userData['email'] ?? '',
      //       );

      //       Provider.of<UserProvider>(context, listen: false).setUser(user);
      //       return const HomeScreen();
      //     }

      //     return const SplashScreen();
      //   },
      // ),
    );
  }
}
