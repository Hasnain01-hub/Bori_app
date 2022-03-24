// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:bori_app/view/screens/MainActivity.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, 1.0),
  ).animate(_controller);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainActivity()),
        );
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FadeTransition(
            opacity: _animation,
            child: Image.asset(
              'assets/images/app-splash-logo.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    FadeTransition(
                      opacity: _animation,
                      child: Image.asset(
                        'assets/images/app-splash-bottom.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Center(
                        child: Text(
                            "The Bhandarkar Oriental \n \t\t\t\tResearch Centre",
                            style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.left),
                      ),
                    ),
                  ],
                ),

                // AnimatedContainer(
                //   curve: Curves.easeIn,
                //   duration: Duration(seconds: 10),
                //   child:Image.asset(
                //     'assets/images/app-splash-bottom.png',
                //     fit: BoxFit.cover,
                //   ) ,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
