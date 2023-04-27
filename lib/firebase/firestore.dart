import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense_model.dart';
import '../models/group_model.dart';
import '../stores/user_store.dart';


class FireStrMtd {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getColl(String name) {
    return _firestore.collection(name);
  }

  createUser(
      {required String email,
      required String uid,
      required String username,
      required String phoneNumber}) async
  {

    List<String> tmp = [];
    Map<String, Map<String, dynamic>> tmp2 = {};
    double a = 0.0;
    await _firestore.collection('users').doc(email).set({
      'uid': uid,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'friends': tmp2,
      'groups': {email : {
        'title': "Non-group expenses",
        'owe': a,
        'groupID': email
      }},
      'activity': tmp,
    });

    await _firestore.collection('groups').doc(email).set({
      'id': email,
      'title': "Non-group expenses",
      'creator': "ADMIN__ADMIN",
      'expenses': tmp,
      'people': tmp2,
      'balances': {email : {}},
    });
  }

saveUserData(String email) async {
  DocumentSnapshot data = await getColl('users').doc(email).get();
  var resp = data.data()! as Map<String, dynamic>;
  UserStore.initialise(resp);
  return "Success";
}

Future<GroupModel> getGroupDetails(String id) async {
  DocumentSnapshot data = await getColl('groups').doc(id).get();
  var resp = data.data()! as Map<String,dynamic>;
  List<String>ids = [];
  for(String x in resp['expenses'])
    {
      ids.add(x);
    }
  List<ExpenseModel>e = [];
  for(String x in ids)
    {
      DocumentSnapshot data2 = await getColl('expenses').doc(x).get();
      var resp2 = data2.data()! as Map<String,dynamic>;
      e.add(ExpenseModel.fromJson(resp2));
    }

  Map<String, Map<String,double>> TT = {};
  for(String person1 in (resp['balances'] as Map<String, dynamic>).keys)
    {
      Map<String,double> T = {};
      for(String person2 in resp['balances'][person1].keys)
      {
        T[person2] = resp['balances'][person1][person2];
      }
      TT[person1] = T;
    }

  var a = GroupModel(id: resp['id'], title: resp['title'], creator:resp['creator'], expenses: e, balances: TT);
  return a;
}


  //
  // createNonGroupExpense(Map<String, dynamic> data)
  // async {
  //   try {
  //     await _firestore.collection('expenses').doc(data['expenseID']).set(data);
  //     for (var person in data['owe'].keys) {
  //       await _firestore.collection('groups').doc(person).update(
  //           {'expenses': FieldValue.arrayUnion([data['expenseID']])});
  //     }
  //
  //     return "Success";
  //   }
  //   catch(e){
  //     return e.toString();
  //   }
  //
  // }
  //
  // createGroupExpense(Map<String, dynamic> data)
  // async {
  //   try {
  //     await _firestore.collection('expenses').doc(data['expenseID']).set(data);
  //       await _firestore.collection('groups').doc(data['groupID']).update(
  //           {'expenses': FieldValue.arrayUnion([data['expenseID']])});
  //     return "Success";
  //   }
  //   catch(e){
  //     return e.toString();
  //   }
  //
  // }
  //
  // addFriend({required String email}) async {
  //   if (email == UserStore.email) {
  //     return "Cant Add Self";
  //   }
  //   else if (UserStore.friends.contains(email)) {
  //     return "Already Added";
  //   }
  //   if (await AuthMtds().checkEmailExists(email)) {
  //     CollectionReference users = getColl('users');
  //     List<String> abcd = [];
  //     try {
  //       await users.doc(email).update({'friends.${UserStore.email}': {
  //         'owe':0,
  //         'activity':abcd
  //       }});
  //       await users.doc(UserStore.email).update({'friends.$email': {
  //         'owe':0,
  //         'activity':abcd
  //       }});
  //       UserStore.friends.add(email);
  //
  //       await LocalStorage.instance.storeData(UserStore.getData(), 'userdata');
  //     } catch (e) {
  //       if (kDebugMode) {
  //         print(e);
  //       }
  //       return "Some Error Occured";
  //     }
  //
  //     return "Added as Friend";
  //   } else {
  //     return "Invalid Email";
  //   }
  // }
  //
  // createGroup({required List<String> people, required String title})
  // async {
  //   people.add(UserStore.email);
  //   List<String> e = [];
  //   String groupID = 'Group${UserStore.email}${DateTime.now()}';
  //   try
  //   {
  //     Map<String,Map<String,double>> tmp2 = {};
  //     for(String person in people)
  //       {
  //         Map<String,double>t = {};
  //         for(String person2 in people)
  //           {
  //             if(person2 != person)
  //               {
  //                 t[person2] = 0;
  //               }
  //           }
  //         tmp2[person] = t;
  //       }
  //
  //     await _firestore.collection('groups').doc(groupID).set({
  //       'title': title,
  //       'creator': UserStore.email,
  //       'people': people,
  //       'expenses': e,
  //       'id': groupID,
  //       'balances': tmp2
  //     });
  //     CollectionReference users = getColl('users');
  //     for(String person in people)
  //     {
  //       await users.doc(person).update({"groups":  FieldValue.arrayUnion([groupID])});
  //     }
  //     await LocalStorage.instance.storeData(UserStore.getData(), 'userdata');
  //     return "Success";
  //   }catch(e){
  //     print(e);
  //     return e.toString();
  //   }
  // }
  //
  // getGroups()
  // async {
  //   try
  //   {
  //     DocumentSnapshot data = await getColl('users').doc(UserStore.email).get();
  //     var resp = data.data()! as Map<String, dynamic>;
  //     Map<String,GroupModel> answer = {};
  //     for(var tmp in resp['groups'])
  //     {
  //       answer[tmp] = GroupModel(title: 'title', people: [], creator: ' ', expenses: [], id: '');
  //     }
  //     for(String groupID in answer.keys) {
  //       DocumentSnapshot data = await getColl('groups').doc(groupID).get();
  //       var resp = data.data()! as Map<String, dynamic>;
  //
  //       if(!resp.containsKey('people'))
  //         {
  //           resp['people'] = UserStore.friends;
  //         }
  //       answer[groupID] = GroupModel.fromJson(resp);
  //     }
  //     print(answer);
  //     return answer;
  //   }
  //   catch(e)
  //   {
  //     throw Exception('Error');
  //   }
  //
  // }
  //
  // Future<Map<String, ExpenseModel>> getGroupExpenses(GroupModel groupModel)
  // async {
  //   try
  //   {
  //     Map<String,ExpenseModel> answer = {};
  //
  //     for(String expsnseID in groupModel.expenses)
  //       {
  //         DocumentSnapshot data = await getColl('expenses').doc(expsnseID).get();
  //         print('apple');
  //         var resp = data.data()! as Map<String, dynamic>;
  //         print(resp);
  //         answer[expsnseID] = ExpenseModel.fromJson(resp);
  //         print("cat");
  //       }
  //     return answer;
  //   }
  //   catch(e)
  //   {
  //     throw Exception('Error');
  //   }
  //
  // }
  //

  //
  // initializeStores()
  // {
  //
  // }
}
