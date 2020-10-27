import 'package:flutter/material.dart';

class AddMoreTransaction extends StatelessWidget {
  final Function onAddPressed;

  AddMoreTransaction({this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAddPressed,
      child: Card(
        child: Container(
          alignment: Alignment.center,
          height: 80.0,
          width: 50.0,
          decoration: BoxDecoration(
            color:  Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(150.0),
          ),
          child: FlatButton.icon(
            label: FittedBox(
              child: Text(
                'Add More Transactions',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
                ),
              ),
            ),
            icon: Icon(
              Icons.add,
              color: Theme.of(context).accentColor,
            ),
            onPressed: onAddPressed,
          ),
        ),
      ),
    );
  }
}
