import 'dart:async';

import 'package:dapetduit_admin/ui/homepage.dart';
import 'package:dapetduit_admin/ui/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    goTimer();

  }


  Future goTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool login = prefs.getBool('login');

    if(login==null) {
      login = false;
    }

  Timer(Duration(seconds: 1), (){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => login? HomePage() : Register()
    ));
  });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitThreeBounce(
          size: 40,
          color: Colors.green,
        ),
      ),
    );
  }
}



