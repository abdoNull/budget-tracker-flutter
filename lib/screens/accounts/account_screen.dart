import 'package:budget_tracker/screens/icons/icon_holder.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  // final Account account ;
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Map<String, dynamic> _data;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  IconData _newIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              //   IconHolder(newIcon: _newIcon),
              IconHolder(
                newIcon: _newIcon,
                onIconChange: (IconData iconData) =>
                    setState(() => _newIcon = iconData),
              ),
              TextFormField(
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
