import 'package:flutter/material.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/main_page.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyDWdioaMZhBxzcBNhjzumwXQRO73PyO7XY",
      authDomain: "smartparkingapp-b16d3.firebaseapp.com",
      databaseURL: "https://smartparkingapp-b16d3-default-rtdb.firebaseio.com",
      projectId: "smartparkingapp-b16d3",
      storageBucket: "smartparkingapp-b16d3.appspot.com",
      messagingSenderId: "1063967171945",
      appId: "1:1063967171945:web:8df71f41c9cd3989ae49f8",
      measurementId: "G-XYFLNL14B9"
  ),);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization= Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.primaryBg
      ),
      home: MainPage(),
    );
  }
}
