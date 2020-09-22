import 'package:budget_tracker/screens/index.dart';
import 'package:flutter/material.dart';

final routes = {
  '/': (context) => HomeScreen(),
//  HomeScreen.routeName: (BuildContext context) => HomeScreen(),
  AccountsScreen.routeName: (BuildContext context) => AccountsScreen(),
  ItemsScreen.routeName: (BuildContext context) => ItemsScreen(),
  TypesScreen.routeName: (BuildContext context) => TypesScreen(),
};

// inErrorCase Try BuildContext
