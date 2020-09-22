import 'package:budget_tracker/screens/accounts/account_screen.dart';
import 'package:flutter/material.dart';

class AccountsScreen extends StatelessWidget {
  static const routeName = '/account-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
