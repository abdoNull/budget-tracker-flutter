import 'package:budget_tracker/database/db_provider.dart';
import 'package:budget_tracker/screens/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypesScreen extends StatelessWidget {
  static const routeName = '/types-screen';
  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<DbProvider>(context);

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
      body: FutureBuilder(
        future: dbProvider.getAllTypes(),
        builder: (_, snaptshot) {
          if (!snaptshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snaptshot.hasError)
            return Center(
              child: Text(snaptshot.error.toString()),
            );
          var types = snaptshot.data;
          if (types.length == 0)
            return Center(
              child: const Text('No Records'),
            );

          return ListView.builder(
            itemCount: types.length,
            itemBuilder: (_, index) {
              var type = types[index];
              return ListTile(
                leading: Icon(type.iconData),
                title: Text(type.name),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TypeScreen(
                      type: type,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
