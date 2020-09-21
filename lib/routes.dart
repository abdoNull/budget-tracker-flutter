import 'package:flutter/material.dart';
import 'package:budget_tracker/screens/index.dart';

final routes = {
  '/': (BuildContext context) => HomeScreen(),
  '/accounts': (BuildContext context) => AccountsScreen(),
  '/items': (BuildContext context) => ItemsScreens(),
  '/types': (BuildContext context) => TypesScreen(),
};