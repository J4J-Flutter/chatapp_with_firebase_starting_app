import 'package:chatapp_with_firebase/pages/chat_page.dart';
import 'package:chatapp_with_firebase/pages/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void onSubmit() {
    //TODO: replace with login with auth service
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatPage(),
      ),
    );
  }

  void navigateToSignUpPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageTitle = 'Login Page';
    const loginBtnText = 'Login';
    const emailHintText = 'Enter your email';
    const passwordHintText = 'Enter your password';
    const signUpBtnText = "Sign Up";
    const newHereText = 'New Here?';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(pageTitle),
      ),
      body: Center(
        child: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.2,
            ),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: emailHintText,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: passwordHintText,
                  ),
                ),
                ElevatedButton(
                  onPressed: onSubmit,
                  child: const Text(loginBtnText),
                ),
                const Divider(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(newHereText),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: navigateToSignUpPage,
                      child: const Text(signUpBtnText),
                    ),
                  ],
                ),
              ]
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: e,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
