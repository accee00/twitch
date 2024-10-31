import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch/provider/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homescreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Center(
        child: Text(userProvider.user.username),
      ),
    );
  }
}
