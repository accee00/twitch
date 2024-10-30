import 'package:flutter/material.dart';
import 'package:twitch/screens/on_board.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 217, 204, 231),
            Color.fromARGB(255, 234, 155, 248),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Image.asset(
          'lib/assets/images/icon.png',
          width: 20,
          height: 200,
        ),
      ),
    );
  }
}
