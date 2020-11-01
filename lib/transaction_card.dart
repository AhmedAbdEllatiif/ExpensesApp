import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final double amount;
  final DateTime dateTime;
  final f = DateFormat('dd-MM-yyyy');
  final Function onDeletePressed;

  //var f =  DateFormat('yyyy-MM-dd  hh:mm');
  TransactionCard({
    this.title,
    this.amount,
    this.dateTime,
    this.onDeletePressed
  });

  @override
  Widget build(BuildContext context) {
    String dateFormatted = f.format(dateTime);
    return Card(
      child: Container(
        width: double.infinity,
        height: 100.0,
        child: Row(
          children: [
            ///Price
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    '\$${amount.toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),

            ///Column title and Date
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Title
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      '$title',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),

                  ///DateTime
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      '$dateFormatted',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.grey[500],),
                    ),
                  ),
                ],
              ),
            ),

           MediaQuery.of(context).size.width > 460 ?
            FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete',),
                textColor: Colors.red,
                onPressed: onDeletePressed,
            )
           : IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDeletePressed,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
