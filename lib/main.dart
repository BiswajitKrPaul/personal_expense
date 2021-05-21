import 'package:flutter/material.dart';
import 'package:personal_expense/database/transaction.dart';
import 'package:personal_expense/expense/expenseItem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Transaction> transaction = [
      Transaction(
        id: 't1',
        name: 'iPhone 12 mini',
        price: 69990,
        date: DateTime.now(),
      ),
      Transaction(
        id: 't2',
        name: 'MacBook Air M1',
        price: 92492,
        date: DateTime.now(),
      ),
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Personal Expense',
          ),
        ),
        body: Container(
          child: Column(
            children: transaction.map((tx) {
              return ExpenseItem(
                transaction: tx,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
