import 'package:flutter/material.dart';
import 'package:splitwise/screens/friends/friend_detail.dart';
import 'package:splitwise/stores/user_store.dart';

import '../functions/email_to_uid.dart';

class FriendTile extends StatelessWidget {
  final String keyo;
  Widget trail = Column();
  FriendTile(this.keyo, {super.key});
  @override
  Widget build(BuildContext context) {
    double owes = UserStore.friends[keyo]!.owe;

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FriendDetail( keyo: keyo,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://media.istockphoto.com/id/517188688/photo/mountain-landscape.jpg?s=612x612&w=0&k=20&c=A63koPKaCyIwQWOTFBRWXj_PwCrR4cEoOw2S9Q7yVl8='),
          ),
          trailing: getTrial(owes),
          title: Text(UIDN(keyo)),

        ),
      ),
    );
  }
}

getTrial(double owes)
{
  if(owes == 0)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Settled Up')
      ],
    );
  }
  else if(owes > 0)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Owes you', style: TextStyle(color: Colors.green),),
        Text('\u{20B9}${owes.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green),),
      ],
    );
  }
  else
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('You Owe', style: TextStyle(color: Colors.orange),),
        Text('\u{20B9}${(-1*owes).toStringAsFixed(2)}', style: const TextStyle(color: Colors.orange),),
      ],
    );
  }
}