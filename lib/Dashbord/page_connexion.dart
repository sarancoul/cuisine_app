import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SafeArea(
                child: Row(
      children: [
        const SizedBox(
          height: 200,
        ),
        Image.asset(
          "assets/images/connexion.png",
          height: 300,
          width: 400,
        )
      ],
    ))));
  }
}
