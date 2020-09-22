import 'package:budget_tracker/screens/index.dart';
import 'package:flutter/material.dart';

class TypesScreen extends StatelessWidget {
  static const routeName = '/types-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Type Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TypeScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
