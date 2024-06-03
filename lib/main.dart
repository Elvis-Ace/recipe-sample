import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:recipe/basedata/basedata.dart';
import 'package:recipe/mystate/cart_store.dart';
import 'package:recipe/pages/cartpage.dart';
import 'package:recipe/pages/homepage.dart';
import 'package:recipe/pages/launchscreen.dart';

void main() {
  runApp(
      Provider(
        create: (_)=>CartStore(),
        child: MaterialApp(
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                  backgroundColor: Basedata.basecolor,
                  iconTheme: const IconThemeData(
                      color: Colors.white
                  )
              )
          ),
          builder: EasyLoading.init(),
          initialRoute: '/',
          routes: {
            '/':(context)=>const Launchscreen(),
            '/home':(context)=>const HomeView(),
            '/cartpage':(context)=>const Cartpage()
          },
        ),
      )
  );
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}