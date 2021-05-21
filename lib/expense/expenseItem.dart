import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/transaction.dart';

class ExpenseItem extends StatelessWidget {
  final Transaction transaction;

  ExpenseItem({this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
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
              '₹ ${transaction.price.toString()}',
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
                transaction.name,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Text(
                DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                    .format(transaction.date),
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
