import 'package:budget_tracker/database/db_provider.dart';
import 'package:budget_tracker/models/balance.dart';
import 'package:budget_tracker/screens/accounts/accounts_screen.dart';
import 'package:budget_tracker/screens/home/widgets/menu.dart';
import 'package:budget_tracker/screens/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _withdraw = 0;
  double _deposit = 0;
  double _wHeight = 0;
  double _dHeight = 0;
  double _balance = 0;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var dbProvider = Provider.of<DbProvider>(context);
    var balance = await dbProvider.getBalance();
    _setHeightBalance(balance);
  }

  void _setHeightBalance(Balance balance) {
    var maxAmount =
        balance.withdraw > balance.deposit ? balance.withdraw : balance.deposit;
    if (maxAmount == 0) {
      setState(() {
        _wHeight = 0;
        _dHeight = 0;
        _withdraw = 0;
        _deposit = 0;
        _balance = 0;
      });
      return;
    }
    var maxHeight = MediaQuery.of(context).size.height - 284;
    var wHeight = (balance.withdraw / maxAmount) * maxHeight;
    var dHeight = (balance.deposit / maxAmount) * maxHeight;
    setState(() {
      _wHeight = wHeight;
      _dHeight = dHeight;
      _withdraw = balance.withdraw;
      _deposit = balance.deposit;
      _balance = balance.total;
    });
  }

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat("#,##0.00", "en_US");

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
            amount: formatter.format(_balance),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 50),
            height: MediaQuery.of(context).size.height - 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _BarLine(
                  height: _wHeight,
                  label: 'Withdraw',
                  color: Colors.red,
                  amount: formatter.format(_deposit),
                ),
                _BarLine(
                  height: _dHeight,
                  label: 'Deposit',
                  color: Colors.teal,
                  amount: formatter.format(_deposit),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
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
  final String amount;

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
        Text(amount),
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
