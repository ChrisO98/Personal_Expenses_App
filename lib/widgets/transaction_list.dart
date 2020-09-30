import 'package:flutter/material.dart';

import '../models/tansaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print('build() TransactionList');
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No Transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10,
                  ), // common way to be used as a seperator a way to give items space between each other, its empty
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ), // include it in your pubspec.yaml
                ],
              );
            },
          )
        : ListView(
            children:
                transactions // if used <Widget>[] then would have to do (...) but since we had only this, its okay
                    .map(
                      (tx) => TransactionItem(
                            key: ValueKey(tx.id), // need to add key to your direct child of your ListView of your list you're creating
                            transaction: tx, // if this rebuilds constantly then do not use UniqueKey()
                            deleteTx: deleteTx,// only a problem if its a StateFulwidget of TransactionItem
                          ),
                    )
                    .toList());
    // ListView.builder(
    //   // the () is an anonymous function
    //   itemBuilder: (ctx, index) {
    //     return TransactionItem(transaction: transactions[index], deleteTx: deleteTx); //extracted code here and put it into its
    //                                                                             // own widget to have code more readable
    //   },
    //   itemCount: transactions.length,
    // );
  }
}
