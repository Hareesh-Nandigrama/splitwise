import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:splitwise/firebase/auth.dart';
import 'package:splitwise/firebase/local_storage.dart';
import 'package:splitwise/stores/user_store.dart';

class FireStrMtd {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  getColl(String name) {
    return _firestore.collection(name);
  }

  createUser(
      {required String email,
      required String uid,
      required String username,
      required String phoneNumber}) async {
    print('Started firestore setup');
    await _firestore.collection('users').doc(email).set({
      'uid': uid,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'friends': [''],
      'groups': [''],
    });
    print('finished firestore setup');
  }

  addFriend({required String email}) async {
    if (email == UserStore.email) {
      return "Cant Add Self";
    } else if (UserStore.friends.contains(email)) {
      return "Already Added";
    }
    if (await AuthMtds().checkEmailExists(email)) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      var doc2 = await users.doc(email).get();
      var resp2 = doc2.data()! as Map<String, dynamic>;
      List<String> tmp2 = [];
      resp2['friends'].forEach((element) {tmp2.add(element as String);});
      List<String> tmp1 = UserStore.friends;
      tmp2.add(UserStore.email);
      tmp1.add(email);

      try {
        await users.doc(email).update({'friends': tmp2});
        await users.doc(UserStore.email).update({'friends': tmp1});

        UserStore.friends = tmp1;
        await LocalStorage.instance.storeData(UserStore.getData(), 'userdata');
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return "Some Error Occured";
      }

      return "Added as Friend";
    } else {
      return "Invalid Email";
    }
  }

  saveUserData(String email) async {
    DocumentSnapshot data =
        await _firestore.collection('users').doc(email).get();
    var resp = data.data()! as Map<String, dynamic>;
    await LocalStorage.instance.storeData(resp, 'userdata');
    UserStore.initialise(resp);
  }
}
