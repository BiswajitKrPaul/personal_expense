import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final Function addTransaction;

  NewExpense(this.addTransaction);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController textInput = TextEditingController();
  final TextEditingController priceInput = TextEditingController();
  DateTime pickedDate;

  void showDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((newDate) {
      if (newDate == null) {
        return;
      }
      setState(() {
        pickedDate = newDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: textInput,
          decoration: InputDecoration(
            hintText: 'Enter name of the product',
            contentPadding: EdgeInsets.all(8.0),
          ),
          keyboardType: TextInputType.text,
        ),
        TextField(
          controller: priceInput,
          decoration: InputDecoration(
            hintText: 'Enter the price',
            contentPadding: EdgeInsets.all(8.0),
          ),
          keyboardType: TextInputType.number,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  pickedDate == null
                      ? 'No Date Chosen !'
                      : 'Picked Date : ${DateFormat.yMd().format(pickedDate)}',
                ),
              ),
            ),
            TextButton(
              onPressed: showDate,
              child: Text(
                'Choose Date',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            widget.addTransaction(
                textInput.text, double.parse(priceInput.text), pickedDate);
            textInput.clear();
            priceInput.clear();
            Navigator.of(context).pop();
          },
          child: Text(
            'Add Transaction',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          style: TextButton.styleFrom(
            primary: Colors.indigo,
          ),
        )
      ],
    );
  }
}
