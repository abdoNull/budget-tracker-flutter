import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Tracker',
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      
   //   initialRoute: '/',
  //    routes: null,
    );
  }
}