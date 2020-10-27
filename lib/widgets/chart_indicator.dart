import 'package:flutter/material.dart';

class ChartIndicator extends StatefulWidget {
  final String day;
  final String date;
  final double amount;
  final percentageOfTotal;

  ChartIndicator(
      {this.date,
      this.day = "?",
      this.amount = 0.0,
      this.percentageOfTotal = 0.0});

  @override
  _ChartIndicatorState createState() => _ChartIndicatorState();
}

class _ChartIndicatorState extends State<ChartIndicator>
    with TickerProviderStateMixin {

  final double spaceVertical = 10.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///Price text
              Container(
                height: (constraints.maxHeight - spaceVertical) * 0.15,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text('\$${widget.amount.toStringAsFixed(0)}'),
                ),
              ),

              ///Percentage
              Container(
                height: (constraints.maxHeight - spaceVertical) * 0.55,
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

              ///Day text
              Container(
                height: (constraints.maxHeight - spaceVertical) * 0.15,
                child: Text('${widget.day}' ?? "?"),
              ),

              ///Date text
              Container(
                height: constraints.maxHeight *  0.15,
                child: Text('${widget.date}' ?? "?"),
              ),
            ],
          ),
        );
      },
    );
  }
}
