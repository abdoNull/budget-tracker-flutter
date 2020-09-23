import 'package:budget_tracker/database/db_provider.dart';
import 'package:budget_tracker/models/account.dart';
import 'package:budget_tracker/screens/icons/icon_holder.dart';
import 'package:budget_tracker/support/icon_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    Key key,
    @required this.account,
  }) : super(key: key);

  final Account account;

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Map<String, dynamic> _data;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //  IconData _newIcon;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.account != null) {
      _data = widget.account.toMap();
    } else {
      _data = Map<String, dynamic>();
      _data['codePoint'] = Icons.add.codePoint;
    }
  }

  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<DbProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              if (!_formKey.currentState.validate()) return;
              _formKey.currentState.save();
              var account = Account.fromMap(_data);
              if (account.id == null)
                await dbProvider.createAccount(account);
              else
                await dbProvider.updateAccount(account);

              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              //   IconHolder(newIcon: _newIcon),
              IconHolder(
                newIcon: IconHelper.createIconData(_data['codePoint']),
                onIconChange: (IconData iconData) =>
                    setState(() => _data['codePoint'] = iconData.codePoint),
              ),
              TextFormField(
                initialValue: widget.account != null ? widget.account.name : '',
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (String value) {
                  if (value.isEmpty) return 'Required';
                  return null;
                },
                onSaved: (String value) => _data['name'] = value,
              ),
              TextFormField(
                initialValue:
                    widget.account != null ? widget.account.balance : '',
                decoration: InputDecoration(
                  labelText: 'Balance',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (String value) {
                  if (value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Invalid number';
                  return null;
                },
                onSaved: (String value) =>
                    _data['balance'] = double.parse(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
