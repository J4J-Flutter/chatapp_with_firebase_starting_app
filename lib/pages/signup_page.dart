import 'package:chatapp_with_firebase/pages/login_page.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  void onSubmit() {
    //TODO: replace with signup with auth service
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatPage(),
      ),
    );
  }

  void navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageTitle = 'Sign Up Page';
    const loginBtnText = 'Submit';
    const emailHintText = 'Enter your email';
    const passwordHintText = 'Enter your password';
    const passwordAgainHintText = 'Confirm your password';

    const alreadySignedUpText = "Already have an account?";
    const loginHereText = "Login here";
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
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: passwordAgainHintText,
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
                    const Text(alreadySignedUpText),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: navigateToLoginPage,
                      child: const Text(loginHereText),
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
