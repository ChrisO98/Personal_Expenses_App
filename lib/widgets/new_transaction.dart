import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:section_4_personal_expenses_app/widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx) {
    print('Constructor NewTransaction Widget');
  }

  @override
  _NewTransactionState createState() {
    print('createState NewTransaction Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print('Constructor NewTransaction State');
  }

  @override // @override is here because the init state is implemented in the State above 'State'<NewTransaction> so want to override
  void initState() {
    
    print('initState()');
    // best to call super.initState() first before anything else in the initState()

    super.initState();
    // super is a key word in dart in which refers to the parent class, So we inherit State on line 20
    // and that means when the new transaction state is created a state object is created as well. And 'super' refers to that parent
    // object to that state object basically and makes sure that we also call 'initState' there in line 32, so that not just oue
    // own in its state function runs but also the one that was built into state. Now before that is called you can do your own
    // initialization and often that is for example used to make an http request and load some data from a server or load dom data
    // from a database, anything like that.
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    // get an argument and that was the previous widget attached to this state
    print('didUpdateWidget()');
    
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    
    super.dispose();
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return; // stops the code so it won't take in any empty title or amount
    }

    // widget. only available in state classes

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context)
        .pop(); // pop method to close the top most screen that is desplayed
  }

  void _presentDatePicker() {
    showDatePicker(
      context:
          context, //refers to argument showDatePicker expects : //refers to class property
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // to tell flutter something updated and should rebuild the widget needed to be rebuilt
        _selectedDate = pickedDate;
      });
    }); // will not stop the code from continuing to get user input
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) =>
                    _submitData(), // now that we have an anonymous function going into another anonymous function we have to manually trigger that function
                // _ The underscore singles getting an argument and that you don't really use it anywhere else
                // onChanged: (val) {
                //   amountInput = val;
                // },
                // or
                // onChanged: (val) => amountInput = val,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}', //constructor .yMd() can give an object .format() to pass in the date selected
                      ),
                    ),
                    AdaptiveFlatButton('Choose Date', _presentDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
