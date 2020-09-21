import 'package:flutter/material.dart';
import 'package:budget_tracker/screens/index.dart';

final routes = {
  '/': (BuildContext context) => HomePage(),
  '/accounts': (BuildContext context) => AccountsPage(),
  '/items': (BuildContext context) => ItemsPage(),
  '/types': (BuildContext context) => TypesPage(),
};