import 'package:flutter/material.dart';
import 'package:twitch/screens/log_in_screen.dart';
import 'package:twitch/screens/signup_screen.dart';
import 'package:twitch/widgets/buttons.dart';

class OnBoardingScreen extends StatelessWidget {
  static const routeName = '/onBoard';
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome\n To Twitch",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomButtons(
                text: 'Log In',
                onTap: () {
                  Navigator.pushNamed(context, LogInScreen.routeName);
                },
              ),
            ),
            CustomButtons(
              text: 'Sign Up',
              onTap: () {
                Navigator.pushNamed(context, SignupScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
