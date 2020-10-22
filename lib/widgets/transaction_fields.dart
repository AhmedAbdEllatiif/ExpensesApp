import 'package:expenses_app/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionFields extends StatefulWidget {
  final Function(Transaction) addTransaction;

  TransactionFields({this.addTransaction});

  @override
  _TransactionFieldsState createState() => _TransactionFieldsState();
}

class _TransactionFieldsState extends State<TransactionFields> {
  TextEditingController _titleController;
  TextEditingController _amountController;
  FocusNode _amountFocusNode;

  String _formattedDate;
  DateTime _chosenDate;
  bool _titleErrorVisibility = false;
  bool _amountErrorVisibility = false;

  @override
  void initState() {
    super.initState();
    _amountFocusNode = FocusNode();
    _titleController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountFocusNode.dispose();
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ///Title TextField
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              onSubmitted: (_) => _amountFocusNode.requestFocus(),
              onChanged: (_) {
                _titleErrorVisibility = false;
                setState(() {});
              },
            ),

            ///Error text for empty title
            Visibility(
              visible: _titleErrorVisibility,
              child: textErrorMessage(
                "Title Required...",
              ),
            ),

            ///Amount TextField
            TextField(
                focusNode: _amountFocusNode,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amountController,
                onSubmitted: (_) => _openDatePicker(),
                keyboardType: TextInputType.number,
                onChanged: (_) {
                  _amountErrorVisibility = false;
                  setState(() {});
                }),

            ///Error text for empty title
            Visibility(
              visible: _amountErrorVisibility,
              child: textErrorMessage(
                "Amount Required...",
              ),
            ),

            ///DatePicker container
            Container(
              height: 70.0,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _formattedDate ?? 'No Date Chosen',
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _openDatePicker,
                  )
                ],
              ),
            ),

            ///Add transaction button
            RaisedButton(
              child: Text('Add Transaction'),
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor,
              onPressed: _submitTransaction,
            )
          ],
        ),
      ),
    );
  }

  ///To return error text with message
  Widget textErrorMessage(String errorMessage) {
    return Container(
      margin: EdgeInsets.only(top: 3.0),
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline_outlined,
            color: Theme.of(context).errorColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              '$errorMessage',
              style: TextStyle(
                color: Theme.of(context).errorColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///To submit new transaction
  void _submitTransaction() {
    if (!isAllFieldsFilled()) return;

    widget.addTransaction(
      Transaction(
        id: DateTime.now().toString(),
        title: '${_titleController.text}',
        amount: double.parse('${_amountController.text}'),
        dateTime: _chosenDate ?? DateTime.now(),
      ),
    );
    Navigator.of(context).pop();
  }

  ///To return true if all fields filled
  bool isAllFieldsFilled() {
    if (_titleController.text.isEmpty && _amountController.text.isEmpty) {
      _titleErrorVisibility = true;
      _amountErrorVisibility = true;
      setState(() {});
      return false;
    }

    if (_titleController.text.isEmpty) {
      _titleErrorVisibility = true;
      setState(() {});
      return false;
    }
    if (_amountController.text.isEmpty) {
      _amountErrorVisibility = true;
      setState(() {});
      return false;
    }
    return true;
  }

  ///To open date picker
  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      _chosenDate = pickedDate;
      _formattedDate = 'Picked Date: ${DateFormat.yMMMd().format(pickedDate)}';
      setState(() {});
    });
  }
}
