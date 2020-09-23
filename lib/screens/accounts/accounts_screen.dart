import 'package:budget_tracker/database/db_provider.dart';
import 'package:budget_tracker/models/models.dart';
import 'package:budget_tracker/screens/accounts/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AccountsScreen extends StatelessWidget {
  static const routeName = '/account-screen';

  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<DbProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountScreen(),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Account>>(
        future: dbProvider.getAllAccount(),
        builder: (_, snaptshot) {
          if (!snaptshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snaptshot.hasError)
            return Center(
              child: Text(snaptshot.error.toString()),
            );

          if (snaptshot.data.length == 0)
            return Center(
              child: const Text('No Records'),
            );
          var formatter = NumberFormat("#,##0.00", "en_US");
          return ListView.builder(
            itemCount: snaptshot.data.length,
            itemBuilder: (_, index) {
              var account = snaptshot.data[index];
              return ListTile(
                leading: Icon(account.iconData),
                title: Text(account.name),
                trailing: Text('\$${formatter.format(account.balance)}'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AccountScreen(
                      account: account,
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
