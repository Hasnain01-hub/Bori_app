import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/view/screens/MainActivity.dart';
import 'package:bori_app/view/screens/SplashScreen.dart';
import 'package:bori_app/viewModel/BookingViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const BoriApp());
  });
}

class BoriApp extends StatelessWidget {
  const BoriApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider.value(value: BookingViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BORI',

        theme: ThemeData(
          appBarTheme: AppBarTheme(centerTitle: true),
          primarySwatch: AppTheme.AppBarTheme,
            fontFamily: 'SF_Pro',
            textTheme: TextTheme(
                headline6: TextStyle(fontSize: 18.0)
            ),


        ),

        initialRoute: '/',
        routes: {
           '/': (context) => SplashScreen(),
        },
      ),
    );
  }
}

