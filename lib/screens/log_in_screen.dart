import 'package:flutter/material.dart';
import 'package:twitch/resource/auth_meathod.dart';
import 'package:twitch/screens/home_screen.dart';
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
  final AuthMethod _authMethod = AuthMethod();
  @override
  void dispose() {
    _logInUserNamecontroller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    bool res = await _authMethod.logInUser(
      context,
      _logInUserNamecontroller.text.trim(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;
    if (res) {
      Navigator.pushNamed(context, HomeScreen.routeName);
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
                  hintText: 'david69@gmail.com',
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
                onTap: loginUser,
              )
            ],
          ),
        ),
      ),
    );
  }
}
