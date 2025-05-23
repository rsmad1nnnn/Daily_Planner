import 'package:flutter/material.dart';

import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';  // Google OAuth Provider
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:get/get.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SignInScreen(
      providers: [
        EmailAuthProvider(),
        GoogleProvider(
          clientId: '425200153710-obl2jb1ouv2t6arr090a4t79uai68dr8.apps.googleusercontent.com',
        ),
      ],
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          Get.offAll(() => const HomeScreen());

          // can easily implement email verifying
          // if (!state.user!.isEmailVerified) {
          //   Navigator.pushNamed(context, '/verify-email');
          // } else {
          //   Navigator.pushReplacementNamed(context, '/profile');
          // }
        }),
      ],
    );
  }
}