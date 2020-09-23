import 'package:budget_tracker/database/db_provider.dart';
import 'package:budget_tracker/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DbProvider>.value(
      value: DbProvider(),
      //dispose 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Budget Tracker',
        theme: ThemeData(primarySwatch: Colors.teal),
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
