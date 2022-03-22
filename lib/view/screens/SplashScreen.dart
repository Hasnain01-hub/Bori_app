// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:bori_app/view/screens/MainActivity.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (context, animation, animationTime, child) {
              animation = CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              );
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (context, animation, animationTime) {
              return MainActivity();
            },
          ),
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          'assets/images/splash.jpeg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
