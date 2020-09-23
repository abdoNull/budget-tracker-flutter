import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({
    Key key,
    @required this.isDeposit,
  }) : super(key: key);

  final bool isDeposit;

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  Map<String, dynamic> _data;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //bool _isDeposit = true;
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data['isDeposit'] = widget.isDeposit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (!_formKey.currentState.validate()) return;
              _formKey.currentState.save();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                validator: (String value) => value.isEmpty ? 'Required' : null,
                onSaved: (String value) => _data['description'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                validator: (String value) {
                  if (value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Invalid';
                  return null;
                },
                onSaved: (String value) => _data['amount'] = value,
              ),
              Row(
                children: [
                  // Checkbox(
                  //   value: _isDeposit,
                  //   onChanged: (bool value) =>
                  //       setState(() => _isDeposit = value),
                  // ),
                  Checkbox(
                    value: _data['isDeposit'],
                    onChanged: (bool value) =>
                        setState(() => _data['isDeposit'] = value),
                  ),
                  const Text('Is Deposit'),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () async {
                      var date = await showDatePicker(
                        context: context,
                        initialDate: _dateTime,
                        firstDate: DateTime.now().add(Duration(days: -365)),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (date = null) return;
                      setState(() => _dateTime = date);
                    },
                  ),
                  Text(DateFormat('MM/dd/yyyy').format(_dateTime))
                ],
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Account',
                ),
                items: [
                  DropdownMenuItem<int>(
                    value: 1,
                    child: const Text('Checking'),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: const Text('Credit Card'),
                  ),
                ],
                onChanged: (int value) => _data['accountId'] == value,
                validator: (int value) => value == null ? 'Required' : null,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Type',
                ),
                items: [
                  DropdownMenuItem<int>(
                    value: 1,
                    child: const Text('Rent'),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: const Text('Dinner'),
                  ),
                ],
                onChanged: (int value) => _data['accountId'] == value,
                validator: (int value) => value == null ? 'Required' : null,
              ),
            ],
          )),
    );
  }
}
