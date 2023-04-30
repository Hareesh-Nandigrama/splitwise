import 'package:flutter/material.dart';

import '../../../firebase/firestore.dart';
import '../../../functions/email_to_uid.dart';
import '../../../functions/pop_up.dart';
import '../../../stores/user_store.dart';

class SettleConfirmPage extends StatefulWidget {
  final String from;
  final String to;
  final String groupId;
  final double amount;
  const SettleConfirmPage({Key? key, required this.from, required this.to, required this.groupId, required this.amount}) : super(key: key);

  @override
  State<SettleConfirmPage> createState() => _SettleConfirmPageState();
}

class _SettleConfirmPageState extends State<SettleConfirmPage> {
  TextEditingController ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ctrl.text = widget.amount.abs().toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Payment'),
        actions: [
          IconButton(onPressed: () async {
            Map<String, dynamic> data = {};
            data['paidBy'] = widget.from;
            data['title'] = '${UIDN(widget.from)} Paid ${UIDN(widget.to)} \u{20B9}${ctrl.text}';
            data['amount'] = double.parse(ctrl.text);
            double a = 0;
            data['owe'] = {
              widget.to : double.parse(ctrl.text),
              widget.from: a,
            };
            data['date'] = DateTime.now();
            data['expenseID'] = "GSExpenses${UserStore.uid}CC${DateTime.now().month}CC${DateTime.now().day}CC${DateTime.now().hour}CC${DateTime.now().minute}CC${DateTime.now().second}";
            data['groupID'] = widget.groupId;
            String response = '';

            if(widget.groupId.substring(0,5) == "Group")
              {
                response = await FireStrMtd().createGroupExpense(data);
              }
            else
              {
                response = await FireStrMtd().createNonGroupExpense(data);
              }
            if (!mounted) return;
            if(response == "Success")
            {
              Navigator.of(context).pop();
              popUp("Payment Recorded", context, 1, 500, Colors.green);
            }
            else
            {
              popUp(response, context, 1, 500, Colors.red);
            }

          }, icon: Icon(Icons.save))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 30,child: Container(color: Colors.red,),),
              Icon(Icons.arrow_right_alt, size: 30,),
              CircleAvatar(radius: 30,child: Container(color: Colors.red,),),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${UIDN(widget.from)} Paid ${UIDN(widget.to)}'),
          ),
          SizedBox(
            width: 150,
            child: TextField(
              controller: ctrl,
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
