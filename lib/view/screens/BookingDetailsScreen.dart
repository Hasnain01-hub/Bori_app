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
Icon actionIcon = new Icon(Icons.search,color: AppTheme.appbar_title,);
Widget appBarTitle = new Text("Conference",style: TextStyle(fontWeight: FontWeight.w800,color: AppTheme.appbar_title,fontSize: 17,));

String finalstitle="";
class BookingDetailsScreen extends StatefulWidget {
 // const BookingDetailsScreen({Key? key, required this.title}) : super(key: key);
  //final String title;

  @override
  _BookingDetailsScreenState createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {

  String dropdownValue = 'Select';
  String FeeValue = '-';


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
      appBar: new AppBar( elevation: 0, backgroundColor: AppTheme.AppBarTheme,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppTheme.appbar_title),
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
                          hintStyle: TextStyle(fontWeight: FontWeight.w800,color: AppTheme.appbar_title,fontSize: 17,)),
                    );
                  } else {
                    actionIcon = new Icon(Icons.search,color: AppTheme.appbar_title,);
                    appBarTitle = new Text("Conference",style: TextStyle(fontWeight: FontWeight.w800,color: AppTheme.appbar_title,fontSize: 17,));
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
              Flexible(child:
              Container(
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
                          child: Text("Purpose for Booking*",style: TextStyle(fontSize: 14.0,color: AppTheme.AppBarTheme,fontWeight: FontWeight.bold),),
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
                          child: Text("Date*",style: TextStyle(fontSize: 14.0,color: AppTheme.AppBarTheme,fontWeight: FontWeight.bold),),
                        ),

                        Container(
                         child: Row(
                              children:[
                                Container(
                          padding: const EdgeInsets.only(left: 20,bottom: 20,right: 8,top: 10),
                          height: 70,
                          width: 88,
                          child:Theme(
                            data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                            child: TextField(
                              autofocus: false,
                              style: TextStyle(fontSize: 14.0, color: AppTheme.AppBarTheme,fontWeight:FontWeight.w400),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppTheme.search_bg,
                                hintText: 'DD',
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
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(left: 8,bottom: 20,right: 8,top: 10),
                                  height: 70,
                                  width: 76,
                                  child:Theme(
                                    data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                                    child: TextField(
                                    //  textAlign: TextAlign.left,
                                      autofocus: false,
                                      style: TextStyle(fontSize: 14.0, color: AppTheme.AppBarTheme,fontWeight:FontWeight.w400),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppTheme.search_bg,
                                        hintText: 'MM',
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
                                  padding: const EdgeInsets.only(left: 8,bottom: 20,right: 8,top: 10),
                                  height: 70,
                                  width: 76,
                                  child:Theme(
                                    data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                                    child: TextField(
                                      autofocus: false,
                                      style: TextStyle(fontSize: 14.0, color: AppTheme.AppBarTheme,fontWeight:FontWeight.w400),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppTheme.search_bg,
                                        hintText: 'YYYY',
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
                                )
                              ])
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 0,left: 20),
                          child: Text("Time slot*",style: TextStyle(fontSize: 14.0,color: AppTheme.AppBarTheme,fontWeight: FontWeight.bold),),
                        ),
                      Container(
                        child:Row(
                          children:[
                      Container(
                          padding: const EdgeInsets.only(left: 20,bottom: 20,right: 8,top: 10),
                          height: 70,
                          width: 88,
                          child:Theme(
                            data: Theme.of(context).copyWith(splashColor: Colors.transparent),

                             child:TextField(
                              autofocus: false,
                              style: TextStyle(fontSize: 14.0, color: AppTheme.AppBarTheme,fontWeight:FontWeight.w400),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppTheme.search_bg,
                                hintText: 'Hrs',
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
                          ),),
                        Container(
                          padding: const EdgeInsets.only(left: 8,bottom: 20,right: 8,top: 10),
                          height: 70,
                          width: 76,
                          child:Theme(
                            data: Theme.of(context).copyWith(splashColor: Colors.transparent),

                            child:TextField(
                              autofocus: false,
                              style: TextStyle(fontSize: 14.0, color: AppTheme.AppBarTheme,fontWeight:FontWeight.w400),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppTheme.search_bg,
                                hintText: 'Min',
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
                          ),),
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                                child:Text("To",style: TextStyle(color: AppTheme.AppBarTheme,fontWeight:FontWeight.normal,fontSize: 16),textAlign: TextAlign.center,)
                            ),
                            Container(
                              child:Row(
                                  children:[
                                    Container(
                                      padding: const EdgeInsets.only(left: 8,bottom: 20,right: 8,top: 10),
                                      height: 70,
                                      width: 76,
                                      child:Theme(
                                        data: Theme.of(context).copyWith(splashColor: Colors.transparent),

                                        child:TextField(
                                          autofocus: false,
                                          style: TextStyle(fontSize: 14.0, color: AppTheme.AppBarTheme,fontWeight:FontWeight.w400),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppTheme.search_bg,
                                            hintText: 'Hrs',
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
                                      ),),
                                    Container(
                                      padding: const EdgeInsets.only(left: 8,bottom: 20,right: 8,top: 10),
                                      height: 70,
                                      width: 76,
                                      child:Theme(
                                        data: Theme.of(context).copyWith(splashColor: Colors.transparent),

                                        child:TextField(
                                          autofocus: false,
                                          style: TextStyle(fontSize: 14.0, color: AppTheme.AppBarTheme,fontWeight:FontWeight.w400,),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppTheme.search_bg,
                                            hintText: 'Min',
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
                                      ),),
                                  ]),),

                          ]),),

                        Container(
                          padding: const EdgeInsets.only(top: 0,left: 20),
                          child: Text("Address*",style: TextStyle(fontSize: 14.0,color: AppTheme.AppBarTheme,fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20,bottom: 20,right: 20,top: 10),
                          height: 101,
                          child:Theme(
                            data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                            child: TextFormField(
                              minLines: 6,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
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
                          child: Text("Email Id*",style: TextStyle(fontSize: 16.0,color: AppTheme.AppBarTheme,fontWeight: FontWeight.bold),),
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
                          margin: EdgeInsets.all(20),
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
