import 'package:expenses_app/utils/database_utils.dart';
import 'package:flutter/material.dart';

class MyTransaction {
  final int id;
  final String title;
  final double amount;
  final DateTime dateTime;
  final int dateTimeMM_stamp;

  MyTransaction({
    this.id,
    @required this.title,
    @required this.amount,
    this.dateTime,
    this.dateTimeMM_stamp
  });

  Map<String,dynamic> toMap(){
    return{
      DatabaseUtils.id :  id,
      DatabaseUtils.transactionTitle : title??"untitled Task",
      DatabaseUtils.transactionAmount : amount??0.0,
      DatabaseUtils.timeStamp : dateTimeMM_stamp?? 0,
    };
  }
}
