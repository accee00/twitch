import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch/widgets/buttons.dart';
import 'package:twitch/widgets/custom_textfield.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = '/login';
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _logInUserNamecontroller =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> logInUserWithEmailAndPassword() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _logInUserNamecontroller.text.trim(),
        password: _passwordController.text.trim(),
      );
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text("Log In error"),
              content: Text(
                e.message.toString(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              const Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomTextfield(
                  obscureText: false,
                  controller: _logInUserNamecontroller,
                  hintText: 'abc@gmail.com',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    CustomTextfield(
                      obscureText: !_isPasswordVisible,
                      controller: _passwordController,
                      hintText: 'Enter Your Password',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              CustomButtons(
                  text: 'Log In',
                  onTap: () async {
                    await logInUserWithEmailAndPassword();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
