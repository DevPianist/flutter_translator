import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../principal/principal_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomSplash(
      imagePath: 'assets/logo.png',
      backGroundColor: Colors.white,
      home: PrincipalScreen(),
      duration: 2500,
      type: CustomSplashType.StaticDuration,
    );
  }
}
