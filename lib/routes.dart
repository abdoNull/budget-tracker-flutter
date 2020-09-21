import 'package:budget_tracker/screens/index.dart';

final routes = {
  '/': (context) => HomeScreen(),
  AccountsScreen.routeName: (context) => AccountsScreen(),
  ItemsScreen.routeName: (context) => ItemsScreen(),
  TypesScreen.routeName: (context) => TypesScreen(),
};

// inErrorCase Try BuildContext 