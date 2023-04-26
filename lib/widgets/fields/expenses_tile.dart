import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Text('Apr'),
                Text('19')
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

                Text('Title', style: TextStyle(color: Colors.black, fontSize: 20),),
                Text('Anjan Paid 300', style: TextStyle(color: Colors.black, fontSize: 15),),
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
                Text('you lent', style: TextStyle(color: Colors.green, fontSize: 15),),
                Text('300', style: TextStyle(color: Colors.green, fontSize: 20),),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
