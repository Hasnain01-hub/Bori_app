import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/view/screens/HomeScreen.dart';
import 'package:bori_app/view/screens/MahabharataProjectScreen.dart';
import 'package:bori_app/view/screens/MoreScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'MiddleScreen.dart';

class MainActivity extends StatefulWidget {
  @override
  _BottomBarState createState() => new _BottomBarState();
}

class _BottomBarState extends State<MainActivity> {
  int _pageIndex = 0;
  late PageController _pageController;

  List<Widget> tabPages = [HomeScreen(),MiddleScreen(),MoreScreen()];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.more_bg,
      // appBar: AppBar(
      //   title: Text('Bhandarkar Oriental Research Institute'),
      // ),
      bottomNavigationBar: Container(
        width: 10,
      //  color: Colors.transparent,
        margin: const EdgeInsets.only(left:10.0,right:10.0,bottom: 10.0,top:0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30),bottomRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(color: Colors.transparent, spreadRadius: 0, blurRadius: 10),
          ],
          // image: DecorationImage(image: AssetImage("assets/images/round_bottom.png"), fit: BoxFit.fill),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
          ),

          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _pageIndex,
            onTap: onTabTapped,
            selectedItemColor: Colors.white,
            backgroundColor: AppTheme.AppBarTheme,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: SvgPicture.asset(
            "assets/images/home_gray.svg",
            height: 20.0,
            width: 20.0,),
                activeIcon: SvgPicture.asset("assets/images/home.svg",height: 20,width: 20,),label:'',  backgroundColor: AppTheme.AppBarTheme, ),
              BottomNavigationBarItem(

                  icon: SvgPicture.asset(
                    "assets/images/bag.svg",
                    height: 20.0,
                    width: 20.0,
                  ),
                activeIcon:  SvgPicture.asset("assets/images/admission_white.svg",height: 20,width: 20,),
           //  icon: Icon(Icons.school),
                  label: '',  backgroundColor: AppTheme.AppBarTheme,),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/dots.svg",
                  height: 10.0,
                  width: 10.0,),
                  activeIcon: SvgPicture.asset("assets/images/more_white.svg",height: 10,width: 10),
                label: '',  backgroundColor: AppTheme.AppBarTheme,)



            ],

          ),
        ),
      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
  Widget showIndicator(bool show) {
    return show
        ? Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Icon(Icons.line_weight, size: 10, color: Colors.orange),
    )
        : SizedBox();
  }

}
