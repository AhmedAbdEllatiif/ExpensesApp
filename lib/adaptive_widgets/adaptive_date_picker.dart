import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveDatePicker {
  void openDatePicker(
      BuildContext context,  onSubmit(DateTime dateTime)) {
     Platform.isIOS
        ? CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            maximumDate: DateTime.now(),
            maximumYear: 10,
            onDateTimeChanged: (pickedDate) {
              onSubmit(pickedDate);
            },
          )
        : showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now(),
          ).then((pickedDate) {
            onSubmit(pickedDate);
          });
  }
}
