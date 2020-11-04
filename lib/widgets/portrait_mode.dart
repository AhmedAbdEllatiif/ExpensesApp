import 'package:expenses_app/database/database_helper.dart';
import 'package:expenses_app/models/transaction_model.dart';
import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PortraitWidget extends StatefulWidget {
  final Function(BuildContext context) onAddTransactionClicked;
  final Function(MyTransaction transaction) onDeleteItemClicked;
  final double appBarHeight;

  const PortraitWidget(
      {this.onAddTransactionClicked,
      this.onDeleteItemClicked,
      this.appBarHeight});

  @override
  _PortraitWidgetState createState() => _PortraitWidgetState();
}

class _PortraitWidgetState extends State<PortraitWidget> {
  List<dynamic> _transactionsList;
  Function(BuildContext context) _onAddTransactionClicked;
  Function(MyTransaction transaction) _onDeleteItemClicked;
  double _appBarHeight;
  var mediaQuery;

  @override
  void initState() {
    _onAddTransactionClicked = widget.onAddTransactionClicked;
    _onDeleteItemClicked = widget.onDeleteItemClicked;
    _appBarHeight = widget.appBarHeight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseBuilder databaseHelper = DatabaseBuilder();
    mediaQuery = MediaQuery.of(context);
    return FutureBuilder(
      initialData: [],
      future: databaseHelper.getAllTransactions(),
      builder: (context, snapshot) {
        _transactionsList = snapshot.data;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(
              percentageHeight: (mediaQuery.size.height -
                      _appBarHeight -
                      mediaQuery.padding.top) *
                  .23,
            ),
            TransactionList(
              onAddTransactionClicked: () => _onAddTransactionClicked(context),
            ),
          ],
        );
      },
    );
  }
}
