import 'package:flutter/material.dart';
import 'package:twitch/screens/home_screen.dart';
import 'package:twitch/widgets/buttons.dart';
import 'package:twitch/widgets/custom_textfield.dart';
import 'package:twitch/resource/auth_meathod.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNamecontroller = TextEditingController();
  bool _isPasswordVisible = false;
  final AuthMethod _authMeathod = AuthMethod();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNamecontroller.dispose();
    super.dispose();
  }

  void signUpUser() async {
    bool res = await _authMeathod.signUpUser(
      context,
      _emailController.text,
      _userNamecontroller.text,
      _passwordController.text,
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
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomTextfield(
                  obscureText: false,
                  controller: _emailController,
                  hintText: 'daveuk34@gmail.com',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'User Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomTextfield(
                  obscureText: false,
                  controller: _userNamecontroller,
                  hintText: 'accee_0',
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
              CustomButtons(text: 'Sign Up', onTap: signUpUser),
            ],
          ),
        ),
      ),
    );
  }
}
