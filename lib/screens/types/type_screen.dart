import 'package:budget_tracker/database/db_provider.dart';
import 'package:budget_tracker/models/item_type.dart';
import 'package:budget_tracker/screens/icons/icon_holder.dart';
import 'package:budget_tracker/support/icon_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeScreen extends StatefulWidget {
  const TypeScreen({
    Key key,
    this.type,
  }) : super(key: key);

  final ItemType type;

  @override
  _TypeScreenState createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
  Map<String, dynamic> _data;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.type != null) {
      _data = widget.type.toMap();
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
        title: Text('Type'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              if (!_formKey.currentState.validate()) return;
              _formKey.currentState.save();
              var type = ItemType.fromMap(_data);
              if (type.id == null)
                await dbProvider.createItemType(type);
              else
                await dbProvider.updateItemType(type);

              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              IconHolder(
                newIcon: IconHelper.createIconData(_data['codePoint']),
                onIconChange: (IconData iconData) =>
                    setState(() => _data['codePoint'] = iconData.codePoint),
              ),
              TextFormField(
                initialValue: widget.type != null ? widget.type.name : '',
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
      ),
    );
  }
}
