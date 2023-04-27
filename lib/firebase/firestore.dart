import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
    List<String> tmp = [];
    await _firestore.collection('users').doc(email).set({
      'uid': uid,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'friends': tmp,
      'groups': [email],
      'activity': tmp,
    });
    print('finished firestore setup');
  }

  createNonGroupExpense(Map<String, dynamic> data)
{

}

  addFriend({required String email}) async {
    if (email == UserStore.email) {
      return "Cant Add Self";
    } else if (UserStore.friends.contains(email)) {
      return "Already Added";
    }
    if (await AuthMtds().checkEmailExists(email)) {
      CollectionReference users = getColl('users');

      try {
        await users.doc(email).update({'friends': FieldValue.arrayUnion([UserStore.email])});
        await users.doc(UserStore.email).update({'friends': FieldValue.arrayUnion([email])});
        UserStore.friends.add(email);

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

  createGroup({required List<String> people, required String title})
  async {
    people.add(UserStore.email);
    List<String> e = [];
    String groupID = 'Group${UserStore.email}${DateTime.now()}';
    try
    {
      await _firestore.collection('groups').doc(groupID).set({
        'title': title,
        'creator': UserStore.email,
        'people': people,
        'expenses': e
      });
      CollectionReference users = getColl('users');
      for(String person in people)
      {
        await users.doc(person).update({"groups":  FieldValue.arrayUnion([groupID])});
      }
      UserStore.groups.add(groupID);
      await LocalStorage.instance.storeData(UserStore.getData(), 'userdata');
      return "Success";
    }catch(e){
      print(e);
      return e.toString();
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
