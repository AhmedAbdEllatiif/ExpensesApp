
import 'package:expenses_app/adaptive_widgets/adaptive_date_picker.dart';
import 'package:expenses_app/adaptive_widgets/adaptive_flat_button.dart';
import 'package:expenses_app/models/transaction_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionFields extends StatefulWidget {
  final Function(MyTransaction) addTransaction;

 const TransactionFields({this.addTransaction});

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
    return SingleChildScrollView(
      child: Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.only(
              top: 15.0,
              left: 15.0,
              right: 15.0,
              bottom: MediaQuery.of(context).viewInsets.bottom + 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Picked Date: ',
                          ),
                          Text(
                            _formattedDate ?? 'No Date Chosen',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15.0
                            ),
                          ),
                        ],
                      ),
                    ),

                    AdaptiveFlatButton(
                      text: 'Choose Date',
                      onPressed: _openDatePicker,
                    ),
                  ],
                ),
              ),

              ///Add transaction button
              RaisedButton(
                child: const Text('Add Transaction'),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
                onPressed: _submitTransaction,
              )
            ],
          ),
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
      MyTransaction(
        title: '${_titleController.text}',
        amount: double.parse('${_amountController.text}'),
        dateTime: _chosenDate ?? DateTime.now(),
        dateTimeMM_stamp: _chosenDate.millisecondsSinceEpoch ??  DateTime.now().millisecondsSinceEpoch
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

  ///To open date picker with respect to platform
  void _openDatePicker() {
   AdaptiveDatePicker().openDatePicker(context, (pickedDate) {
     if (pickedDate == null) return;
     setState(() {
       _chosenDate = pickedDate;
       _formattedDate =
       '${DateFormat.yMMMd().format(pickedDate)}';
     });
   });
  }
}
