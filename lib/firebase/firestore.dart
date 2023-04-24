import 'package:cloud_firestore/cloud_firestore.dart';

class FireStrMtd
{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  getColl(String name) {return _firestore.collection(name);}

  createUser({required String email, required String uid, required String username, required String phoneNumber}) async
  {
    print('Started firestore setup');
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber
    });
    print('finished firestore setup');
  }

  getUserdata({required String id})async
  {
    print('awaiting user information');
    DocumentSnapshot data = await _firestore.collection('users').doc(id).get();
    return data;
  }


}