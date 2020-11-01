import 'dart:io';

import 'package:expenses_app/transaction_card.dart';
import 'package:expenses_app/widgets/add_more_transactions_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction_model.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionsList;

  final Function(Transaction transaction) onDeleteItemClicked;
  final Function() onAddTransactionClicked;

  const TransactionList(
      {this.transactionsList,
      this.onDeleteItemClicked,
      this.onAddTransactionClicked});

  @override
  Widget build(BuildContext context) {
    return transactionsList.isEmpty ? _noTransactionView : _transactionsView;
  }

  Widget get _transactionsView {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            //Transaction transaction = transactionsList[index];
            bool lastItem = index == transactionsList.length;
            return Platform.isIOS && lastItem
                ? AddMoreTransaction(
                    onAddPressed: onAddTransactionClicked,
                  )
                : lastItem
                    ? Container()
                    : transactionCardModel(index);
          },
          itemCount: transactionsList.length + 1,
          /*children: [
            Column(
              children: [
                ..._transactionsList.map((transaction) {
                  return TransactionCard(
                    title: transaction.title,
                    amount: transaction.amount,
                    dateTime: transaction.dateTime,
                  );
                }).toList(),
              ],
            ),
          ],*/
        ),
      ),
    );
  }

  ///No Transaction view
  Widget get _noTransactionView {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Text(
              'No transaction added yet!',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: constraints.maxHeight * .5,
              child: Image(
                image: AssetImage(
                  'assets/images/waiting.png',
                ),
                fit: BoxFit.cover,
              ),
            )
          ],
        );
      },
    );
  }

  ///Model for transaction card
  Widget transactionCardModel(index) {
    Transaction transaction = transactionsList[index];
    return TransactionCard(
      title: transaction.title,
      amount: transaction.amount,
      dateTime: transaction.dateTime,
      onDeletePressed: () {
        onDeleteItemClicked(transaction);
      },
    );
  }

  ///Testing for listTile
  Widget listTileForTesting(context, index) {
    Transaction transaction = transactionsList[index];

    double amount = transaction.amount;
    String title = transaction.title;
    String dateFormatted = DateFormat.yMMMd().format(transaction.dateTime);

    return Card(
      shadowColor: Theme.of(context).primaryColor,
      elevation: 5.0,
      child: Container(
        height: 100.0,
        alignment: Alignment.center,
        child: ListTile(
          ///leading
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 30.0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(
                child: Text(
                  '\$${amount.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          ///Title
          title: Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              '$title',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),

          ///DateTime
          subtitle: Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              '$dateFormatted',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.grey[500],
              ),
            ),
          ),

          ///delete icon
          trailing: IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              onDeleteItemClicked(transaction);
            },
          ),
        ),
      ),
    );
  }
}
