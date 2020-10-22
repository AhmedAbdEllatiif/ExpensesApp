import 'package:flutter/material.dart';

class ChartIndicator extends StatefulWidget  {
  final String day;
  final String date;
  final double amount;
  final percentageOfTotal;

  ChartIndicator({this.date,this.day = "?", this.amount = 0.0,this.percentageOfTotal=0.0});

  @override
  _ChartIndicatorState createState() => _ChartIndicatorState();
}

class _ChartIndicatorState extends State<ChartIndicator>  with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text('\$${widget.amount.toStringAsFixed(0)}'),
          ),
          Container(
            height: 60.0,
            width: 15.0,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                AnimatedSize(
                  vsync: this,
                  duration: Duration(seconds: 1),
                  child: FractionallySizedBox(
                    heightFactor: widget.percentageOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),

                  ),
                )
              ],
            ),
          ),
          Text('${widget.day}' ?? "?"),
          Text('${widget.date}' ?? "?"),
        ],
      ),
    );
  }
}
