import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/transaction.dart';

class ExpenseItem extends StatefulWidget {
  final Transaction transaction;

  ExpenseItem({this.transaction});

  @override
  _ExpenseItemState createState() => _ExpenseItemState();
}

class _ExpenseItemState extends State<ExpenseItem> {
  final List<Transaction> transactions = [
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.map((tx) {
        return (Card(
          elevation: 5.0,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(
                  15.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.indigo,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.all(
                  8.0,
                ),
                child: Text(
                  '₹ ${tx.price.toString()}',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.name,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Text(
                    DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(tx.date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
      }).toList(),
    );
  }
}
