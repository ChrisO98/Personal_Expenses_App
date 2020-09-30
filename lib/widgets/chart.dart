import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/tansaction.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTansactions;

  Chart(this.recentTansactions) {
    print('Constructor Chart');
  }

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0; // good practice to define the type we will have

      for (var i = 0; i < recentTansactions.length; i++) {
        if (recentTansactions[i].date.day == weekDay.day &&
            recentTansactions[i].date.month == weekDay.month &&
            recentTansactions[i].date.year == weekDay.year) {
          totalSum += recentTansactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalSum
      }; // return the map
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build() Chart');
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding( // can use this instead of container but still need to set the padding property
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionsValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar( // can skip unnecessary widget rebuilds if you mark a widget as concept here when using it in the 
                  data['day'],// widget tree
                  data['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                ),
              );
              // Text('${data['day']}: ${data['amount']}'); //OR  data['day'] + ' : ' + data['amount'].toString(),
            }).toList(),
          ),
        ),
    );
  }
}
