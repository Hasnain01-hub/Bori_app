import 'package:bori_app/model/BookingModel.dart';
import 'package:bori_app/model/apis/ApiResponse.dart';
import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/view/screens/MoreScreen.dart';
import 'package:bori_app/viewModel/BookingViewModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'MoreScreen.dart';

int _currentIndex = 0;
bool pressed_About = false;
bool pressed_elebrum = false;
bool pressed_contact = false;


final List<String> imagesList = [
  'assets/images/slide1.png',
  'assets/images/vector.png',
];
Widget appBarTitle = new Text("Emblem",style: TextStyle(fontWeight: FontWeight.w800,color: AppTheme.appbar_title,fontSize: 17,));
Icon actionIcon = new Icon(Icons.search,color: AppTheme.appbar_title,);

class EmblemScreen extends StatefulWidget {


  @override
  _EmblemScreenState createState() => _EmblemScreenState();

}

class _EmblemScreenState extends State<EmblemScreen> {
  Widget getMediaWidget(BuildContext context, ApiResponse apiResponse) {
    List<BookingModel>? mediaList = apiResponse.data as List<BookingModel>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8, child: Text("Child home"),
              // child: PlayerListWidget(mediaList!, (BookingModel media) {
              //   Provider.of<BookingViewModel>(context, listen: false)
              //       .setSelectedMedia(media);
              // }),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomCenter,
                // child: PlayerWidget(
                //   function: () {
                //     setState(() {});
                //   },
                // ),
              ),
            ),
          ],
        );
      case Status.ERROR:
        return Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return Center(
          child: Text('Search the song by Artist'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();
    ApiResponse apiResponse = Provider
        .of<BookingViewModel>(context)
        .response;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color.fromRGBO(100, 41, 8, 50),
        //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: AppTheme.AppBarTheme,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppTheme.appbar_title),
            onPressed: () => Navigator.of(context, rootNavigator: true)
                .pop()
    ),
          centerTitle: true,
          title:appBarTitle,
          actions: <Widget>[
            new IconButton(icon: actionIcon,onPressed:(){
              setState(() {
                if (actionIcon.icon == Icons.search){
                  actionIcon = new Icon(Icons.close);
                  appBarTitle = new TextField(
                      style: TextStyle(fontWeight: FontWeight.w800,color: AppTheme.appbar_title,fontSize: 17,),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search,color: AppTheme.appbar_title),
                        hintText: "Search...",
                        hintStyle: TextStyle(fontWeight: FontWeight.w800,color: AppTheme.appbar_title,fontSize: 17,),
                    ),
                  );}
                else {
                  actionIcon = new Icon(Icons.search,color: AppTheme.appbar_title,);
                  appBarTitle = new Text("Emblem",style: TextStyle(fontWeight: FontWeight.w800,color: AppTheme.appbar_title,fontSize: 17,));
                }


              });
            } ,),]
      ),

      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),

        child: new Column(
          children:[
            Container(
              // color: AppTheme.more_bg,
              decoration: BoxDecoration(
                color:AppTheme.deco, //color: C
              ),
              child: Container(

                //   padding: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppTheme.more_bg,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0),
                  ),),
                child: new Column(
                  children:[

                    Stack(
                      //alignment:new Alignment(x, y)
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Image.asset("assets/images/emblem_logo.png",width: 200,height: 200,),
                         ],
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      //   alignment: AlignmentDirectional.topCenter,
                      child:Text(
"The BORI emblem is in every way the perfect symbol of the objectives and the scholastic tradition of the Institute. The simple handmade sketch with elegant ornamentation is an inspiration to Indological scholars all over the world! The three ornamented letters ‘B-O-R’ are seen interlinked. They are the initials of the words ‘Bhandarkar Oriental Research’ which form the very name of the Institute.\n\n\n The popular Vedic chant ॥तेजस्वि नावधीतमस्तु॥ is an age-old prayer, made in all serenity, by the community of teachers in unison with the students wishing – “May our learning-together be splendid!” It is significant of the vow that the Gurus of Indology had assumed while establishing the Institute.",                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 30,
                        style: TextStyle(color: AppTheme.deco,fontSize: 16,fontWeight: FontWeight.w400),
                      ),),
                  ],
                ),

              ),

            ),
          ],
        ),

      ),
    );
  }
}
