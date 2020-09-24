import 'package:budget_tracker/database/db_provider.dart';
import 'package:budget_tracker/models/item.dart';
import 'package:budget_tracker/screens/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ItemsScreen extends StatelessWidget {
 static const routeName = '/items-screen';
  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<DbProvider>(context);
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
                  builder: (_) => ItemScreen(isDeposit: null,),
                ),
              );
            },
          ),
        ],
      ),
        body: FutureBuilder<List<Item>>(
        future: dbProvider.getAllItems(),
        builder: (_, snaptshot) {
          if (!snaptshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snaptshot.hasError)
            return Center(
              child: Text(snaptshot.error.toString()),
            );
            var items =snaptshot.data;
          if (items.length == 0)
            return Center(
              child: const Text('No Records'),
            );
          var formatter = NumberFormat("#,##0.00", "en_US");
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, index) {
              var item = items[index];
              return  ListTile(
                    leading: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: item.isDeposit ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                    ),
                    title: Text(item.description),
                    trailing: Text('\$${formatter.format(item.amount)}'),
                  );
            },
          );
        },
      ),
    );
  }
}