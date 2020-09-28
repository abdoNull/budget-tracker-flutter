import 'package:budget_tracker/database/db_provider.dart';
import 'package:budget_tracker/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ItemScreen extends StatefulWidget {
  ItemScreen({@required this.isDeposit});
  final bool isDeposit;
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  Map<String, dynamic> _formData = Map<String, dynamic>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Account> _accounts = [];
  List<ItemType> _types = [];
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _formData['isDeposit'] = widget.isDeposit;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadDropdownData();
  }

  void _loadDropdownData() async {
    var dbProvider = Provider.of<DbProvider>(context);
    var accounts = await dbProvider.getAllAccounts();
    var types = await dbProvider.getAllTypes();

    if (!mounted) return;

    setState(() {
      _accounts = accounts;
      _types = types;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (!_formKey.currentState.validate()) return;
              print('object ----- 1');
              _formKey.currentState.save();
              print('object ----- 2');
              var dbProvider = Provider.of<DbProvider>(context,listen: false);
              _formData['date'] = DateFormat('MM/dd/yyyy').format(_dateTime);
              print('object ----- 3');
              var item = Item.fromMap(_formData);
              dbProvider.createItem(item);
              print('object ----- 4');
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (String value) => value.isEmpty ? 'Required' : null,
                onSaved: (String value) => _formData['description'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                validator: (String value) {
                  if (value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Invalid number';
                  return null;
                },
                onSaved: (String value) =>
                    _formData['amount'] = double.parse(value),
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _formData['isDeposit'],
                    onChanged: (bool value) {
                      setState(() {
                        _formData['isDeposit'] = value;
                      });
                    },
                  ),
                  const Text('Is Deposit'),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () async {
                      var date = await showDatePicker(
                        context: context,
                        initialDate: _dateTime,
                        firstDate: DateTime.now().add(
                          Duration(days: -365),
                        ),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );

                      if (date == null) return;

                      setState(() {
                        _dateTime = date;
                      });
                    },
                  ),
                  Text(DateFormat('MM/dd/yyyy').format(_dateTime)),
                ],
              ),
              DropdownButtonFormField<int>(
                value: _formData['accountId'],
                decoration: InputDecoration(labelText: 'Account'),
                items: _accounts
                    .map((a) => DropdownMenuItem<int>(
                          value: a.id,
                          child: Text(a.name),
                        ))
                    .toList(),
                validator: (int value) => value == null ? 'Required' : null,
                onChanged: (int value) {
                  setState(() {
                    _formData['accountId'] = value;
                  });
                },
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Type'),
                value: _formData['typeId'],
                items: _types
                    .map((t) =>
                        DropdownMenuItem<int>(value: t.id, child: Text(t.name)))
                    .toList(),
                onChanged: (int value) {
                  setState(() {
                    _formData['typeId'] = value;
                  });
                },
                validator: (int value) => value == null ? 'Required' : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
