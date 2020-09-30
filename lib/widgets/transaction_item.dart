import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/tansaction.dart';

// Customary to have imports as such
// 1. dart imports
// 2. 3rd party package imports
// 3. custom file imports

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key); // super refers to the parent class 'StatefulWidget', by calling super like a function you are instantiation the parent class
  // only need ot do it on your own if you want to pass on extra data to the parent class
  // super(key: key); is called a Constructor Initialize or list!!!!!!
  final Transaction
      transaction; // this is create for a singel transaction so don't need to take in a list
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  
  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];
    
    _bgColor = availableColors[Random().nextInt(4)];//doing '()' next to random is instantiating
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            // could be const but it has a child that is dynamic so using const here would not work
            padding: const EdgeInsets.all(
                6), // this is static so we can use const and doing Ctrl+LeftClick on EdgeInsets
            child: FittedBox(
                // will take us to the EdgeInsets class and we see that it has the const in front of it so it makes sense
                child: Text(
                    '\$${widget.transaction.amount}')), // dynamic not static
          ),
        ),
        title: Text(
          // using const here would not work because the text does change dynamically
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(
              widget.transaction.date), // same here, const would not work
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text(
                    'Delete'), // this does not change and its a SatelessWidget it not dynamic so using const here makes since
                textColor: Theme.of(context)
                    .errorColor, // it saves time in rebuilding the widget
                onPressed: () => widget.deleteTx(widget.transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.deleteTx(widget.transaction.id),
              ),
      ),
    );
  }
}
