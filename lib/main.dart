import 'package:flutter/material.dart';
import 'package:personal_expense/expense/expenseItem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Personal Expense',
          ),
        ),
        body: Container(
          child: ExpenseItem(),
        ),
      ),
    );
  }
}
