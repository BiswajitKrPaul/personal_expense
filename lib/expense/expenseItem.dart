import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/transaction.dart';

class ExpenseItem extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  ExpenseItem({this.transactions, this.deleteTransaction});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: FittedBox(
                    child: Text('₹ ${transactions[index].price}'),
                  ),
                ),
              ),
              title: Text(
                '${transactions[index].name}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                    .format(transactions[index].date),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteTransaction(index),
                color: Theme.of(context).accentColor,
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
