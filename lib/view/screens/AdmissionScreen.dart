import 'package:bori_app/model/BookingModel.dart';
import 'package:bori_app/model/apis/ApiResponse.dart';
import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/viewModel/BookingViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

int _currentIndex = 0;
bool pressed_About = false;
bool pressed_elebrum = false;
bool pressed_contact = false;

final List<String> imagesList = [
  'assets/images/slide1.png',
  'assets/images/vector.png',
];
Widget appBarTitle = new Text("Admission",style: TextStyle(fontWeight: FontWeight.w800,color: AppTheme.appbar_title,fontSize: 17,));
Icon actionIcon = new Icon(Icons.search,color: AppTheme.appbar_title,);

class AdmissionScreen extends StatefulWidget {
  @override
  _AdmissionScreenState createState() => _AdmissionScreenState();
}

class _AdmissionScreenState extends State<AdmissionScreen> {
  String dropdownValue = 'Mahabharata';
  String FeeValue = '2400';


  List <String> spinnerItems = [
    'Mahabharata',
  ] ;
  List <String> valueItems = [
    '2400',
  ] ;
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
    ApiResponse apiResponse = Provider.of<BookingViewModel>(context).response;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color.fromRGBO(100, 41, 8, 50),
        //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      appBar: new AppBar( elevation: 0,
          backgroundColor: AppTheme.AppBarTheme,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: appBarTitle,
          actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (actionIcon.icon == Icons.search) {
                    actionIcon = new Icon(Icons.close);
                    appBarTitle = new TextField(
                        style: TextStyle(fontWeight: FontWeight.w800,color: AppTheme.appbar_title,fontSize: 17,),
                      decoration: new InputDecoration(
                          prefixIcon:
                          new Icon(Icons.search, color: AppTheme.appbar_title),
                          hintText: "Search...",
                          hintStyle: TextStyle(fontWeight: FontWeight.w800,color: AppTheme.appbar_title,fontSize: 17,),
                      ) );
                  } else {
                    actionIcon = new Icon(Icons.search,color: AppTheme.appbar_title,);
                    appBarTitle = new Text("Admission",style: TextStyle(fontWeight: FontWeight.w800,color: AppTheme.appbar_title,fontSize: 17,));
                  }
                });
              },
            ),
          ]),
      body: Container(
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                // color: AppTheme.more_bg
                decoration: BoxDecoration(
                  color: AppTheme.deco, //color: C
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
                    ),
                  ),
                  child:SingleChildScrollView(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20,left: 20),
                        child: Text("Name*",style: TextStyle(fontSize: 14.0,color: AppTheme.AppBarTheme,fontWeight: FontWeight.bold),),

                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20,bottom: 20,right: 20,top: 10),
                        height: 70,
                        child:Theme(
                            data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                            child: TextField(
                              autofocus: false,
                              style: TextStyle(fontSize: 14.0, color: AppTheme.AppBarTheme,fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppTheme.search_bg,
                                hintText: 'Enter Name',
                                hintStyle: TextStyle(color: AppTheme.AppBarTheme),

                                contentPadding:
                               const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                enabledBorder: OutlineInputBorder(

                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide: BorderSide(color: AppTheme.more_bg)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide: BorderSide(color: AppTheme.more_bg)),
                                ),
                              ),
                            ),

                          ),
                      Container(
                        padding: const EdgeInsets.only(top: 0,left: 20),
                        child: Text("Email*",style: TextStyle(fontSize: 14.0,color: AppTheme.AppBarTheme,fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20,bottom: 20,right: 20,top: 10),
                        height: 70,
                        child:Theme(
                          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                          child: TextField(
                            autofocus: false,
                            style: TextStyle(fontSize: 14.0, color: AppTheme.AppBarTheme,fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppTheme.search_bg,
                              hintText: 'Enter Email',
                              hintStyle: TextStyle(color: AppTheme.AppBarTheme),

                              contentPadding:
                              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                              enabledBorder: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(23.0),
                                  borderSide: BorderSide(color: AppTheme.more_bg)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(23.0),
                                  borderSide: BorderSide(color: AppTheme.more_bg)),
                            ),
                          ),
                        ),

                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 0,left: 20),
                        child: Text("Contact Number*",style: TextStyle(fontSize: 14.0,color: AppTheme.AppBarTheme,fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20,bottom: 20,right: 20,top: 10),
                        height: 70,
                        child:Theme(
                          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                          child: TextField(
                            autofocus: false,
                            style: TextStyle(fontSize: 14.0, color: AppTheme.AppBarTheme,fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppTheme.search_bg,
                              hintText: 'Enter Contact Number',
                              hintStyle: TextStyle(color: AppTheme.AppBarTheme),

                              contentPadding:
                              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                              enabledBorder: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(23.0),
                                  borderSide: BorderSide(color: AppTheme.more_bg)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(23.0),
                                  borderSide: BorderSide(color: AppTheme.more_bg)),
                            ),
                          ),
                        ),

                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 0,left: 20),
                        child: Text("Address*",style: TextStyle(fontSize: 14.0,color: AppTheme.AppBarTheme,fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20,bottom: 20,right: 20,top: 10),
                        height: 70,
                        child:Theme(
                          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                          child: TextField(
                            autofocus: false,
                            style: TextStyle(fontSize: 14.0, color: AppTheme.AppBarTheme,fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppTheme.search_bg,
                              hintText: 'Enter Address',
                              hintStyle: TextStyle(color: AppTheme.AppBarTheme),

                              contentPadding:
                              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                              enabledBorder: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(23.0),
                                  borderSide: BorderSide(color: AppTheme.more_bg)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(23.0),
                                  borderSide: BorderSide(color: AppTheme.more_bg)),
                            ),
                          ),
                        ),

                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 0,left: 20),
                        child: Text("Age*",style: TextStyle(fontSize: 14.0,color: AppTheme.AppBarTheme,fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20,bottom: 20,right: 20,top: 10),
                        height: 70,
                        child:Theme(
                          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                          child: TextField(
                            autofocus: false,
                            style: TextStyle(fontSize: 14.0, color: AppTheme.AppBarTheme,fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppTheme.search_bg,
                              hintText: 'Enter Age',
                              hintStyle: TextStyle(color: AppTheme.AppBarTheme),

                              contentPadding:
                              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                              enabledBorder: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(23.0),
                                  borderSide: BorderSide(color: AppTheme.more_bg)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(23.0),
                                  borderSide: BorderSide(color: AppTheme.more_bg)),
                            ),
                          ),
                        ),

                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 0,left: 20),
                        child: Text("Course*",style: TextStyle(fontSize: 16.0,color: AppTheme.AppBarTheme,fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20,bottom: 20,right: 20,top: 10),
                        height: 70,
                        child:Theme(
                          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                            child:DropdownButtonFormField<String>(

                              style: TextStyle(fontSize: 14.0, color: AppTheme.AppBarTheme,fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppTheme.search_bg,
                                contentPadding:
                                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0,right: 20),
                                enabledBorder: OutlineInputBorder(

                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide: BorderSide(color: AppTheme.more_bg)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide: BorderSide(color: AppTheme.more_bg)),
                              ),
                              onChanged: (var _data) {
                                setState(() {
                                  dropdownValue = _data!;
                                });
                              },
                              hint:Text('Select'),
                              dropdownColor: AppTheme.more_bg,
                              icon: SvgPicture.asset("assets/images/spinner_down.svg",allowDrawingOutsideViewBox: false,width: 10,height: 10,),

                              items: spinnerItems.map<DropdownMenuItem<String>>((String _value) {
                                return DropdownMenuItem<String>(
                                  value: _value,
                                  child: Text(_value),
                                );
                              }).toList(),
                            ),

                        ),

                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(dropdownValue +' Course Fee  -  ₹'+FeeValue, style: TextStyle(fontSize: 16, color: AppTheme.AppBarTheme)),
                      ),
                      Container(
                        margin: EdgeInsets.all(30),
                        child:SvgPicture.asset("assets/images/proceed_btn.svg",width: 157,height: 40,),alignment: Alignment.center,),

                    ],
                  ),
                  ),
                ),
              ),
              ),
            ]),
      ),
    );
  }
}
