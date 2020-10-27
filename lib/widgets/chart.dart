import 'package:expenses_app/models/transaction_model.dart';
import 'package:expenses_app/widgets/chart_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  final List<Transaction> transactionList;
  final percentageHeight;

  Chart({this.transactionList, @required this.percentageHeight});

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  bool _usedDaysOnly = false;
  String _text;
  double _percentageHeight;
  @override
  void initState() {
    _percentageHeight = widget.percentageHeight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _text = _usedDaysOnly ? 'Show All Expenses' : 'Show only expenses  Days';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
      child: Container(
        child: Column(
          children: [
            FlatButton(
                onPressed: () {
                  setState(() {
                    _usedDaysOnly = !_usedDaysOnly;
                  });
                },
                child: Text(
                  _text,
                  style: Theme.of(context).textTheme.headline5,
                )),
            Card(
              elevation: 6.0,
              shadowColor: Theme.of(context).primaryColor,
              child: Container(
                height: _percentageHeight,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return listOfExpensesPerCurrentMonth[index];
                  },
                  itemCount: listOfExpensesPerCurrentMonth.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///To return list of expenses per current month
  List<ChartIndicator> get listOfExpensesPerCurrentMonth {
    List<ChartIndicator> myList = List();
    final weekDay = DateTime.now();
    for (DateTime indexDay = DateTime(weekDay.year, weekDay.month, 1);
        indexDay.month == weekDay.month;
        indexDay = indexDay.add(Duration(days: 1))) {
      String dayLetter = DateFormat.E().format(indexDay);
      double totalSumPerDay = 0.0;
      double totalSumPerMonth = expensesPerMonth;
      double percentageDayPerMonth = 0.0;
      String date = DateFormat('dd/MM').format(indexDay);

      for (Transaction tx in widget.transactionList) {
        if (tx.dateTime.day == indexDay.day &&
            tx.dateTime.month == indexDay.month &&
            tx.dateTime.year == indexDay.year) {
          totalSumPerDay = totalSumPerDay + tx.amount;
        }
      }

      percentageDayPerMonth =
          totalSumPerMonth == 0.0 ? 0.0 : (totalSumPerDay / totalSumPerMonth);

      myList.add(ChartIndicator(
        day: dayLetter,
        amount: totalSumPerDay,
        percentageOfTotal: percentageDayPerMonth,
        date: date,
      ));
      totalSumPerDay = 0.0;
    }

    return _usedDaysOnly
        ? myList.where((element) => element.amount > 0.0).toList()
        : myList;
  }

  ///To return sum of expenses per current month
  double get expensesPerMonth {
    double totalSumPerMonth = 0.0;
    final weekDay = DateTime.now();
    for (DateTime indexDay = DateTime(weekDay.year, weekDay.month, 1);
        indexDay.month == weekDay.month;
        indexDay = indexDay.add(Duration(days: 1))) {
      //print(indexDay.toString());
      for (Transaction tx in widget.transactionList) {
        if (tx.dateTime.day == indexDay.day &&
            tx.dateTime.month == indexDay.month &&
            tx.dateTime.year == indexDay.year) {
          totalSumPerMonth = totalSumPerMonth + tx.amount;
        }
      }
    }
    return totalSumPerMonth;
  }
}
