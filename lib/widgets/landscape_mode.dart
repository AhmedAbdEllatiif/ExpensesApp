import 'package:expenses_app/models/transaction_model.dart';
import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LandscapeWidget extends StatefulWidget {
  final List<Transaction> transactionsList;
  final Function(BuildContext context) onAddTransactionClicked;
  final Function(Transaction transaction) onDeleteItemClicked;
  final double appBarHeight;


  const LandscapeWidget({ this.transactionsList,this.onAddTransactionClicked,this.onDeleteItemClicked,this.appBarHeight});

  @override
  _LandscapeWidgetState createState() => _LandscapeWidgetState();
}

class _LandscapeWidgetState extends State<LandscapeWidget> {

  bool _isShowCharts ;
  List<Transaction> _transactionsList;
  Function(BuildContext context) _onAddTransactionClicked;
  Function(Transaction transaction) _onDeleteItemClicked;
  double _appBarHeight;
  var mediaQuery;


  @override
  void initState() {
    _isShowCharts = true;
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isShowCharts ? 'Hide Charts' : 'Show Charts',
              style: Theme.of(context).textTheme.headline6,
            ),
            Switch.adaptive(
              //adaptive to adapt ios and android
              activeColor: Theme.of(context).accentColor,
              value: _isShowCharts,
              onChanged: (value) {
                setState(() => _isShowCharts = value);
              },
            ),
          ],
        ),
        _isShowCharts
            ? Chart(
          transactionList: _transactionsList,
          percentageHeight: (mediaQuery.size.height -
              _appBarHeight - //for appbar height
              mediaQuery.padding.top) // for status bar height
              *
              .5,
        )
            : TransactionList(
          transactionsList: _transactionsList.reversed.toList(),
          onAddTransactionClicked: () => _onAddTransactionClicked(context),
          onDeleteItemClicked: (transaction) => _onDeleteItemClicked(transaction),
        ),
      ],
    );
  }

}
