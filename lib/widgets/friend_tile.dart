import 'package:flutter/material.dart';
import 'package:splitwise/screens/friends/friend_detail.dart';
import 'package:splitwise/stores/user_store.dart';

import '../functions/email_to_uid.dart';

class FriendTile extends StatelessWidget {
  final String keyo;
  Widget trail = Column();
  FriendTile(this.keyo);
  @override
  Widget build(BuildContext context) {
    double owes = UserStore.friends[keyo]!.owe;
    if(owes == 0)
      {
        trail = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Settled Up')
          ],
        );
      }
    else if(owes > 0)
      {
        trail = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Owes you', style: TextStyle(color: Colors.green),),
            Text(owes.toString(), style: TextStyle(color: Colors.green),),
          ],
        );
      }
    else
      {
        trail = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You Owe', style: TextStyle(color: Colors.orange),),
            Text((-1*owes).toString(), style: TextStyle(color: Colors.orange),),
          ],
        );
      }

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FriendDetail( keyo: keyo,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://media.istockphoto.com/id/517188688/photo/mountain-landscape.jpg?s=612x612&w=0&k=20&c=A63koPKaCyIwQWOTFBRWXj_PwCrR4cEoOw2S9Q7yVl8='),
          ),
          trailing: trail,
          title: Text(UIDN(keyo)),

        ),
      ),
    );
  }
}