import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {

  final Function onPressed;
  final String text;


 const AdaptiveFlatButton({this.onPressed, this.text = 'Nothing to display!!!!'});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor
        ),
      ),
      onPressed: onPressed?? (){},
    )
        : FlatButton(
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      textColor: Theme.of(context).primaryColor,
      onPressed: onPressed?? (){},
    );
  }
}
