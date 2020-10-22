import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/transaction_fields.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:expenses_app/widgets/user_transaction.dart';
import 'package:flutter/material.dart';

import 'models/transaction_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        errorColor: Colors.red,
        accentColor: Color(0xFF152238),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline5: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18.0,
              fontWeight: FontWeight.bold
          ),

          button: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),

        ),

        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6:  TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 22.0,
              fontWeight: FontWeight.bold
            ),
          )
        )
      ),
      home: MyHomePage(),
    );
  }
}




class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactionsList = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 60.99,
      dateTime: DateTime.now().add(Duration(days: 1)),
    ),
    Transaction(
      id: 't2',
      title: 'New Watch',
      amount: 1500.99,
      dateTime: DateTime.now().subtract(Duration(days: 17)),
    ),

    Transaction(
      id: 't3',
      title: 'New Wallet',
      amount: 800.99,
      dateTime:  DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't3',
      title: 'New Wallet',
      amount: 800.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'New Wallet',
      amount: 800.99,
      dateTime:  DateTime.now().add(Duration(days: 3)),
    ),
  ];

  void deleteItem(transaction){
    setState(() {
    transactionsList.remove(transaction);
    });
  }


  ///To open bottom sheet to start a new transaction
  void startNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bCtx) {
        return TransactionFields(
          addTransaction: (transaction) {
            setState(() {
              transactionsList.add(transaction);
            });
          },
        );
      },
    );
  }


  List<Transaction> get lastWeekTransactions{
    return transactionsList.where((tx) {
    final dayBeforeSevenDays = tx.dateTime.subtract(Duration(days: DateTime.now().day - 7),);
      return tx.dateTime.isAfter(dayBeforeSevenDays);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    print("Build method is here");
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('"Flutter App"'),
        centerTitle: true,
      ),

      ///Body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Chart(transactionList: lastWeekTransactions,),

          TransactionList(
            transactionsList:  transactionsList.reversed.toList(),
            onDeleteItemClicked: (transaction){
              deleteItem(transaction);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          startNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
