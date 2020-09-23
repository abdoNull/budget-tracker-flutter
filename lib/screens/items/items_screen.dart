import 'package:budget_tracker/screens/index.dart';
import 'package:flutter/material.dart';

class ItemsScreen extends StatelessWidget {
 static const routeName = '/items-screen';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Items Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ItemScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}