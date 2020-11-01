import 'package:expenses_app/models/transaction_model.dart';
import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PortraitWidget extends StatefulWidget {
  final List<Transaction> transactionsList;
  final Function(BuildContext context) onAddTransactionClicked;
  final Function(Transaction transaction) onDeleteItemClicked;
  final double appBarHeight;

  const PortraitWidget(
      {this.transactionsList,
      this.onAddTransactionClicked,
      this.onDeleteItemClicked,
      this.appBarHeight});

  @override
  _PortraitWidgetState createState() => _PortraitWidgetState();
}

class _PortraitWidgetState extends State<PortraitWidget> {
  List<Transaction> _transactionsList;
  Function(BuildContext context) _onAddTransactionClicked;
  Function(Transaction transaction) _onDeleteItemClicked;
  double _appBarHeight;
  var mediaQuery;

  @override
  void initState() {
    _transactionsList = widget.transactionsList;
    _onAddTransactionClicked = widget.onAddTransactionClicked;
    _onDeleteItemClicked = widget.onDeleteItemClicked;
    _appBarHeight = widget.appBarHeight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Chart(
          transactionList: _transactionsList,
          percentageHeight: (mediaQuery.size.height -
                  _appBarHeight -
                  mediaQuery.padding.top) *
              .23,
        ),
        TransactionList(
            transactionsList: _transactionsList.reversed.toList(),
            onAddTransactionClicked: () => _onAddTransactionClicked(context),
            onDeleteItemClicked: (transaction) {
              setState(() {
                _onDeleteItemClicked(transaction);
              });
            }),
      ],
    );
  }
}
