import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/database/transaction.dart';
import 'package:personal_expense/widgets/chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].price;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransaction.fold(0.0, (previousValue, element) {
      return (previousValue + element['amount']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Row(
        children: groupedTransaction.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            ),
          );
        }).toList(),
      ),
    );
  }
}
