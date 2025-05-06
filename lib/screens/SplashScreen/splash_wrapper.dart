import 'package:flutter/material.dart';
import 'package:pregnancy_tracker/my_app.dart';
import 'package:pregnancy_tracker/screens/SplashScreen/splash_screen.dart';

class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  bool _showSplash = true;

  @override
  Widget build(BuildContext context) {
    return _showSplash
        ? SplashScreen(
          onAnimationComplete: () {
            setState(() {
              _showSplash = false;
            });
          },
        )
        : const MainNavigationWrapper();
  }
}