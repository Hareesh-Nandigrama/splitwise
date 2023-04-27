import 'package:flutter/material.dart';
import 'package:splitwise/models/expense_model.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  final ExpenseModel expmodel;
  const ExpenseTile({Key? key, required this.expmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(DateFormat('MMM').format(expmodel.date)),
                  Text(expmodel.date.day.toString()),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        child: Image.network("https://cdn-icons-png.flaticon.com/512/570/570170.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(expmodel.title, style: TextStyle(color: Colors.black, fontSize: 20),),
                  Text('${expmodel.paidBy} Paid ${expmodel.amount}', style: TextStyle(color: Colors.black, fontSize: 10),),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('you lent', style: TextStyle(color: Colors.green, fontSize: 10),),
                  Text('300', style: TextStyle(color: Colors.green, fontSize: 15),),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
