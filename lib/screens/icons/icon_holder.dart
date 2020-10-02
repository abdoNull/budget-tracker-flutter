import 'package:budget_tracker/screens/icons/icons_screen.dart';
import 'package:flutter/material.dart';

typedef void OnIconChange(IconData iconData);

class IconHolder extends StatelessWidget {
  const IconHolder(
      {Key key,
      @required this.newIcon,
      @required this.onIconChange,
      @required this.tagId})
      : super(key: key);

  final IconData newIcon;
  final OnIconChange onIconChange;
  final int tagId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var iconData = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IconsScreen(),
          ),
        );
        // setState(() {
        //   _newIcon = iconData;
        // });
        onIconChange(iconData);
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.blueGrey,
          ),
        ),
        child: Hero(
          tag: tagId,
          child: Icon(
            newIcon == null ? Icons.add : newIcon,
            size: 60,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
