import 'package:flutter/material.dart';
import 'package:temutemu/util/color.dart';
import 'package:temutemu/views/dashboard.dart';
import 'package:temutemu/views/login.dart';

void main()  => runApp(MyApp()); 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
          primarySwatch: ColorStandard.color,
          ),
      home: new LoginPage(),routes: {
      	Dashboard.routeName: (BuildContext context) => new Dashboard()
	    },
    );
  }
}