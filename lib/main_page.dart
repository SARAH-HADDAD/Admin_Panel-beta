import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:responsive_dashboard/home_page.dart';
import 'package:responsive_dashboard/login.dart';
import 'login.dart';
import 'package:responsive_dashboard/dashboard.dart';
class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<User>(
          stream:FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return Dashboard();
    }
        else{
         return Login();
        }
    },
      ),
    );
  }
}
