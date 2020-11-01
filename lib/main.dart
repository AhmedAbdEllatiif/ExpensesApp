import 'dart:io';

import 'package:expenses_app/widgets/landscape_mode.dart';
import 'package:expenses_app/widgets/portrait_mode.dart';
import 'package:expenses_app/widgets/transaction_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/transaction_model.dart';

void main() {
  ///To force app be in portrait mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );
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
                  fontWeight: FontWeight.bold),
              button:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                )),
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
  var mediaQuery;

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);

    ///Scaffold
    return Platform.isIOS
        ? CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,

            ///Body
            child: SafeArea(child: body),

            ///appbar
            navigationBar: appBar,
          )
        : Scaffold(
            resizeToAvoidBottomPadding: false,

            ///appbar
            appBar: appBar,

            ///Body
            body: SafeArea(child: body),

            ///floatingActionButton
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () {
                      startNewTransaction(context);
                    },
                    child: Icon(Icons.add),
                  ),
          );
  }

  ///To return body of app
  Widget get body {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.landscape
            ? LandscapeWidget(
                onAddTransactionClicked: (context) => startNewTransaction(context),
                onDeleteItemClicked: (transaction) => deleteItem(transaction),
                transactionsList: transactionsList,
                appBarHeight: appBar.preferredSize.height,
              )
            : PortraitWidget(
                onAddTransactionClicked: (context) => startNewTransaction(context),
                onDeleteItemClicked: (transaction) => deleteItem(transaction),
                transactionsList: transactionsList,
                appBarHeight: appBar.preferredSize.height,
              );
      },
    );
  }



  ///To return appbar with respect to platform
  PreferredSizeWidget get appBar {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => startNewTransaction(context),
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Expenses'),
            centerTitle: true,
            actions: [
              Platform.isIOS
                  ? IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () => startNewTransaction(context),
                    )
                  : Container()
            ],
          );
  }

  ///To delete item
  void deleteItem(transaction) {
      transactionsList.remove(transaction);
  }

  ///To open bottom sheet to start a new transaction
  void startNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
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

  ///To return last 7 days of transaction
  List<Transaction> get lastWeekTransactions {
    return transactionsList.where((tx) {
      final dayBeforeSevenDays = tx.dateTime.subtract(
        Duration(days: DateTime.now().day - 7),
      );
      return tx.dateTime.isAfter(dayBeforeSevenDays);
    }).toList();
  }

  ///Default list of transactions
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
      dateTime: DateTime.now().subtract(Duration(days: 1)),
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
      dateTime: DateTime.now().add(Duration(days: 3)),
    ),
  ];
}
