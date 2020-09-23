import 'package:budget_tracker/screens/index.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    return SizedBox(
      width: 100,
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: 100,
              alignment: Alignment.bottomCenter,
              child: Text(
                'MENU',
                style: TextStyle(
                  fontSize: 20,
                  color: color,
                ),
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            _MenuItem(
                title: 'Accounts',
                color: color,
                icon: Icons.account_balance,
                onTap: () => _onNavigate(context, AccountsScreen.routeName)),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            _MenuItem(
                title: 'Budget Items',
                color: color,
                icon: Icons.attach_money,
                onTap: () => _onNavigate(context, ItemsScreen.routeName)),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            _MenuItem(
                title: 'Types',
                color: color,
                icon: Icons.widgets,
                onTap: () => _onNavigate(context, TypesScreen.routeName)),
            Divider(
              height: 20,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  void _onNavigate(BuildContext context, String url) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(url);
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    Key key,
    @required this.color,
    @required this.title,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Color color;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Opacity(
        opacity: 0.6,
        child: Container(
          height: 70,
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Icon(icon, color: color, size: 50.0),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
