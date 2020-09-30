
import 'package:flutter/foundation.dart'; // to get @required

// Blueprint for how a transaction should look like
// Will not be a widget
class Transaction {
  final String id;
  final String title;
  // int or double, wel if we want 99.99 then we would use double
  final double amount;
  final DateTime date;
  // This are the four properties that make up a transation

  // Values passed in, gonna do named arguments so use {} inside of () looks like this ({this.name, this.wow})
  Transaction({
    @required this.id, 
    @required this.title, 
    @required this.amount, 
    @required this.date
  });
}
