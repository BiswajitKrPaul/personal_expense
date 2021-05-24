import 'package:flutter/material.dart';
import 'package:personal_expense/widgets/chat.dart';
import 'package:personal_expense/widgets/newexpense.dart';
import './database/transaction.dart';
import './expense/expenseItem.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.pink,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(
        days: 7,
      )));
    }).toList();
  }

  void _addTransaction(
      String titleInput, double priceInput, DateTime dateTime) {
    final Transaction newTransaction = Transaction(
        id: DateTime.now().toString(),
        name: titleInput,
        price: priceInput,
        date: dateTime);
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _removeTransaction(index) {
    print(index);
    setState(() {
      _transactions.removeAt(index);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return GestureDetector(
          child: NewExpense(_addTransaction),
          behavior: HitTestBehavior.opaque,
          onTap: () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text(
        'Personal Expense',
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    final expenseList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: ExpenseItem(
        transactions: _transactions,
        deleteTransaction: _removeTransaction,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Column(
        children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Show Chart'),
                Switch(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                ),
              ],
            ),
          if (!isLandscape)
            Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.3,
              child: Chart(_recentTransaction),
            ),
          if (!isLandscape)
            _transactions.length == 0
                ? Center(
                    child: const Text(
                      'No Transactions',
                    ),
                  )
                : expenseList,
          if (isLandscape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(_recentTransaction),
                  )
                : _transactions.length == 0
                    ? Center(
                        child: const Text('No Transactions'),
                      )
                    : expenseList,
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
