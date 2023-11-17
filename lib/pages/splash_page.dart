import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -60,
            left: 0,
            child: Image.asset("assets/images/imagesoupe.png"),
          ),
          Positioned(
            bottom: -10,
            right: 0,
            child: Image.asset("assets/images/mage2.png"),
          ),
          Center(
            child: Image.asset(
              "assets/images/icone.png",
              height: 100,
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
