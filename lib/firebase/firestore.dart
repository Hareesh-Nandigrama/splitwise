import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:splitwise/firebase/auth.dart';
import 'package:splitwise/firebase/local_storage.dart';
import 'package:splitwise/models/expense_model.dart';
import 'package:splitwise/models/group_model.dart';
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
    await _firestore.collection('groups').doc(email).set({
      'creator': email,
      'expenses': tmp,
      'title': "Non-group expenses",
      'id': email
    });
    print('finished firestore setup');
  }

  createNonGroupExpense(Map<String, dynamic> data)
  async {
    try {
      await _firestore.collection('expenses').doc(data['expenseID']).set(data);
      for (var person in data['owe'].keys) {
        await _firestore.collection('groups').doc(person).update(
            {'expenses': FieldValue.arrayUnion([data['expenseID']])});
      }

      return "Success";
    }
    catch(e){
      return e.toString();
    }

  }

  createGroupExpense(Map<String, dynamic> data)
  async {
    try {
      await _firestore.collection('expenses').doc(data['expenseID']).set(data);
        await _firestore.collection('groups').doc(data['groupID']).update(
            {'expenses': FieldValue.arrayUnion([data['expenseID']])});
      return "Success";
    }
    catch(e){
      return e.toString();
    }

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
        'expenses': e,
        'id': groupID
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

  getGroups()
  async {
    try
    {
      DocumentSnapshot data = await getColl('users').doc(UserStore.email).get();
      var resp = data.data()! as Map<String, dynamic>;
      Map<String,GroupModel> answer = {};
      for(var tmp in resp['groups'])
      {
        answer[tmp] = GroupModel(title: 'title', people: [], creator: ' ', expenses: [], id: '');
      }
      for(String groupID in answer.keys) {
        DocumentSnapshot data = await getColl('groups').doc(groupID).get();
        var resp = data.data()! as Map<String, dynamic>;

        if(!resp.containsKey('people'))
          {
            resp['people'] = UserStore.friends;
          }
        answer[groupID] = GroupModel.fromJson(resp);
      }
      print(answer);
      return answer;
    }
    catch(e)
    {
      throw Exception('Error');
    }

  }

  Future<Map<String, ExpenseModel>> getGroupExpenses(GroupModel groupModel)
  async {
    try
    {
      Map<String,ExpenseModel> answer = {};

      for(String expsnseID in groupModel.expenses)
        {
          DocumentSnapshot data = await getColl('expenses').doc(expsnseID).get();
          print('apple');
          var resp = data.data()! as Map<String, dynamic>;
          print(resp);
          answer[expsnseID] = ExpenseModel.fromJson(resp);
          print("cat");
        }
      return answer;
    }
    catch(e)
    {
      throw Exception('Error');
    }

  }

  saveUserData(String email) async {
    DocumentSnapshot data =
        await _firestore.collection('users').doc(email).get();
    var resp = data.data()! as Map<String, dynamic>;
    await LocalStorage.instance.storeData(resp, 'userdata');
    UserStore.initialise(resp);
  }

  initializeStores()
  {

  }

}
