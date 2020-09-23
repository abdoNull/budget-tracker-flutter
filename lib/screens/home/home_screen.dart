import 'package:budget_tracker/screens/accounts/accounts_screen.dart';
import 'package:budget_tracker/screens/home/widgets/menu.dart';
import 'package:budget_tracker/screens/index.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    var amount = '1,203.00';
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'add',
            onPressed: () => print('Click'),
          )
        ],
      ),
      drawer: Menu(),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.add,
      //     size: 60,
      //   ),

      //   onPressed: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (_) => ItemScreen()),
      //   ),
      // ),
      floatingActionButton: PopupMenuButton(
        child: Icon(
          Icons.add_circle,
          size: 60,
          color: Theme.of(context).primaryColor,
        ),
        itemBuilder: (_) => [
          PopupMenuItem(
            value: 1,
            child: const Text('Deposit'),
          ),
          PopupMenuItem(
            value: 2,
            child: const Text('Withdraw'),
          ),
        ],
        onSelected: (int value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ItemScreen(
              isDeposit: value == 2,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _TotalBudget(
            amount: amount,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 50),
            height: MediaQuery.of(context).size.height - 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _BarLine(
                  height: 100,
                  label: 'Withdraw',
                  color: Colors.red,
                  amount: 506,
                ),
                _BarLine(
                  height: 300,
                  label: 'Deposit',
                  color: Colors.teal,
                  amount: 1709,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  // _BarLine
}

class _BarLine extends StatelessWidget {
  const _BarLine({
    Key key,
    @required this.height,
    @required this.label,
    @required this.color,
    @required this.amount,
  }) : super(key: key);

  final double height;
  final String label;
  final Color color;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: height,
          width: 100,
          color: color,
        ),
        Text(label),
        Text('\$$amount'),
      ],
    );
  }
}

class _TotalBudget extends StatelessWidget {
  const _TotalBudget({
    Key key,
    @required this.amount,
  }) : super(key: key);

  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Text(
        '\$$amount',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green,
            Colors.white54,
            Colors.blueGrey,
          ],
          stops: [0.85, 0.95, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    );
  }
}
