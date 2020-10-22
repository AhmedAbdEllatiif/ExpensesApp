

import 'package:expenses_app/models/transaction_model.dart';
import 'package:expenses_app/widgets/transaction_fields.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';



class UserTransaction extends StatefulWidget {
   final List<Transaction> transactionsList;


   UserTransaction(this.transactionsList);

  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  List<Transaction> _transactionsList;

  @override
  void initState() {
    super.initState();
    _transactionsList = widget.transactionsList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///UserInput with textField
        // TransactionFields(
        //   addTransaction: (transaction) {
        //     setState(() {
        //     _transactionsList.add(transaction);
        //     });
        //   },
        // ),

        ///TransactionList
        //TransactionList(_transactionsList),
      ],
    );
  }
}
