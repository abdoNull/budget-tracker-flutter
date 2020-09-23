import 'package:flutter/material.dart';

class TypeScreen extends StatefulWidget {
  @override
  _TypeScreenState createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
  Map<String, dynamic> _data;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  IconData _newIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Type'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
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
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.blueGrey,
                ),
              ),
              child: Icon(
                _newIcon = _newIcon == null ? Icons.add : _newIcon,
                size: 60,
                color: Colors.blueGrey,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Type'),
              validator: (String value) {
                if (value.isEmpty) return 'Required';
                return null;
              },
              onSaved: (String value) => _data['name'] = value,
            ),
          ],
        ),
      ),
    );
  }
}
