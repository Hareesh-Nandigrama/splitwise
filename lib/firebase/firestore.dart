import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../functions/email_to_uid.dart';
import '../models/expense_model.dart';
import '../models/group_model.dart';
import '../models/user_friends_model.dart';
import '../models/user_groups_model.dart';
import '../stores/mapping_store.dart';
import '../stores/user_store.dart';
import 'auth.dart';

class FireStrMtd {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getColl(String name) {
    return _firestore.collection(name);
  }

  Future<String> mapping() async {
    DocumentSnapshot data = await getColl('users').doc('mapping').get();
    var resp = data.data()! as Map<String, dynamic>;
    for (var uid in resp.keys) {
      MappingStore.mapping[uid] = resp[uid];
    }
    data = await getColl('users').doc('dp').get();
    if(data.data() == null)
      {
        return "Success";
      }
    resp = data.data()! as Map<String, dynamic>;
    for (var uid in resp.keys) {
      MappingStore.dp[uid] = resp[uid];
    }
    return "Success";
  }

  updateDP(String dp)
  async {
    await getColl('users')
        .doc('dp')
        .set({UserStore.uid: dp}, SetOptions(merge: true));
  }

  createUser(
      {required String email,
      required String uid,
      required String username,
      required String phoneNumber}) async {
    List<String> tmp = [];
    Map<String, Map<String, dynamic>> tmp2 = {};
    double a = 0.0;
    await getColl('users').doc(uid).set({
      'uid': uid,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'friends': tmp2,
      'groups': {
        uid: {'title': "Non-group expenses", 'owe': a, 'groupID': uid}
      },
      'activity': tmp,
    });

    await getColl('users')
        .doc('mapping')
        .set({email: uid, uid: username}, SetOptions(merge: true));

    await getColl('groups').doc(uid).set({
      'id': uid,
      'title': "Non-group expenses",
      'creator': "ADMIN__ADMIN",
      'expenses': tmp,
      'people': tmp2,
      'balances': {uid: {}},
    });
  }

  Future<String> saveUserData() async {
    mapping();
    DocumentSnapshot data =
        await getColl('users').doc(AuthMtds().getUid()).get();

    var resp = data.data()! as Map<String, dynamic>;
    UserStore.initialise(resp);
    return "Success";
  }

  Future<GroupModel> getGroupDetails(String id) async {
    mapping();
    DocumentSnapshot data = await getColl('groups').doc(id).get();
    var resp = data.data()! as Map<String, dynamic>;

    List<String> ids = [];
    for (String x in resp['expenses']) {
      ids.add(x);
    }
    List<ExpenseModel> e = [];
    for (String x in ids) {
      DocumentSnapshot data2 = await getColl('expenses').doc(x).get();
      var resp2 = data2.data()! as Map<String, dynamic>;
      e.add(ExpenseModel.fromJson(resp2));
    }

    Map<String, Map<String, double>> TT = {};
    for (String person1 in resp['balances'].keys) {
      Map<String, double> T = {};
      for (String person2 in resp['balances'][person1].keys) {
        T[person2] = resp['balances'][person1][person2] as double;
      }
      TT[person1] = T;
    }

    var a = GroupModel(
        id: resp['id'],
        title: resp['title'],
        creator: resp['creator'],
        expenses: e,
        balances: TT);

    return a;
  }



  addFriend({required String email}) async {
    if (email.isEmpty) {
      return "Email cannot be empty";
    }
    if (email == UserStore.email) {
      return "Cant Add Self";
    } else if (UserStore.friends.keys.contains(email)) {
      return "Already Added";
    }
    if (await AuthMtds().checkEmailExists(email)) {
      CollectionReference users = getColl('users');
      CollectionReference groups = getColl('groups');
      List<String> abcd = [];
      try {
        double a = 0;
        await users.doc(EUID(email)).set({
          'friends': {
            EUID(UserStore.email): {'owe': a, 'activity': abcd}
          }
        }, SetOptions(merge: true));
        await users.doc(EUID(UserStore.email)).set({
          'friends': {
            EUID(email): {'owe': a, 'activity': abcd}
          }
        }, SetOptions(merge: true));
        await groups.doc(UserStore.uid).set({
          'balances': {
            UserStore.uid: {
              EUID(email): a,
            }
          }
        }, SetOptions(merge: true));
        await groups.doc(EUID(email)).set({
          'balances': {
            EUID(email): {
              UserStore.uid: a,
            }
          }
        }, SetOptions(merge: true));

        UserStore.friends[EUID(email)] =
            UserFriendModel(owe: 0, activity: abcd);
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

  createGroup({required List<String> people, required String title}) async {
    people.add(UserStore.email);
    List<String> e = [];
    String groupID =
        'Group${UserStore.uid}CC${DateTime.now().month}CC${DateTime.now().day}CC${DateTime.now().hour}CC${DateTime.now().minute}CC${DateTime.now().second}';
    try {
      Map<String, Map<String, double>> tmp2 = {};
      for (String person in people) {
        Map<String, double> t = {};
        for (String person2 in people) {
          if (person2 != person) {
            t[EUID(person2)] = 0;
          }
        }
        tmp2[EUID(person)] = t;
      }

      await getColl('groups').doc(groupID).set({
        'title': title,
        'creator': UserStore.uid,
        'expenses': e,
        'id': groupID,
        'people': {},
        'balances': tmp2
      });

      await getColl('expenses').doc('Group$groupID').set(ExpenseModel(
        type: '',
          title: title,
          paidBy: UserStore.uid,
          amount: 0,
          expenseID: 'Group$groupID',
          date: DateTime.now(),
          owe: {},
          groupID: groupID)
          .toJson());

      CollectionReference users = getColl('users');
      double a = 0;
      for (String person in people) {
        await users.doc(EUID(person)).set({
          'activity': FieldValue.arrayUnion(['Group$groupID']),
          "groups": {
            groupID: {'title': title, 'owe': a, 'groupID': groupID}
          }
        }, SetOptions(merge: true));
      }
      UserStore.groups[groupID] =
          UserGroupModel(title: title, owe: 0, groupID: groupID);


      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  addToGroup(GroupModel model, String email)
  async {
    try {
      double a = 0;
      CollectionReference users = getColl('users');
      await users.doc(EUID(email)).set({
        'activity': FieldValue.arrayUnion(['Group${model.id}']),
        "groups": {
          model.id: {'title': model.title, 'owe': a, 'groupID': model.id}
        }
      }, SetOptions(merge: true));

      Map<String, Map<String, double>> tmp2 = {};
      Map<String,double> tt = {};
      for(String person in model.balances.keys)
        {
          Map<String,double>t = {};
          for(String person2 in model.balances[person]!.keys)
          {
            t[person2] = model.balances[person]![person2]!;
          }
          tt[person] = a;
          t[EUID(email)] = a;
          tmp2[person] = t;
        }
      tmp2[EUID(email)] = tt;


      await getColl('groups').doc(model.id).update({
        'balances': tmp2
      });

      return 'Success';
    }
    catch(e)
    {
      return e.toString();
    }
  }

  createGroupExpense(Map<String, dynamic> data) async {
    try {
      //create the expense document
      await getColl('expenses').doc(data['expenseID']).set(data);

      CollectionReference uc = getColl('users');
      Map<String, dynamic> ttt = {
        'activity': FieldValue.arrayUnion([data['expenseID']]),
        'groups.${data['groupID']}.owe':
            FieldValue.increment(data['amount'] - data['owe'][UserStore.uid]),
      };
      for (String person in data['owe'].keys) {
        if (person != UserStore.uid) {
          //updating the individual user profiles
          await uc.doc(person).update({
            'friends.${UserStore.uid}.activity':
                FieldValue.arrayUnion([data['expenseID']]),
            'friends.${UserStore.uid}.owe':
                FieldValue.increment(data['owe'][person] * -1),
            'activity': FieldValue.arrayUnion([data['expenseID']]),
            'groups.${data['groupID']}.owe':
                FieldValue.increment(-1 * data['owe'][person]),
          });
          ttt['friends.$person.activity'] =
              FieldValue.arrayUnion([data['expenseID']]);
          ttt['friends.$person.owe'] =
              FieldValue.increment(data['owe'][person]);
        }
      }

      //Update profile of current user
      await uc.doc(UserStore.uid).update(ttt);

      CollectionReference clrf = getColl('groups');
      Map<String, dynamic> input = {
        'expenses': FieldValue.arrayUnion([data['expenseID']]),
      };
      for (String person in data['owe'].keys) {
        if (person != UserStore.uid) {
          input['balances.$person.${UserStore.uid}'] =
              FieldValue.increment(data['owe'][person] * -1);
          input['balances.${UserStore.uid}.$person'] =
              FieldValue.increment(data['owe'][person]);
        }
      }
      await clrf.doc(data['groupID']).update(input);
      return "Success";
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  createNonGroupExpense(Map<String, dynamic> data) async {
    //Create expense
    await getColl('expenses').doc(data['expenseID']).set(data);
    CollectionReference uc = getColl('users');
    Map<String, dynamic> ttt = {
      'activity': FieldValue.arrayUnion([data['expenseID']]),
      'groups.${UserStore.uid}.owe':
          FieldValue.increment(data['amount'] - data['owe'][UserStore.uid]),
    };

    print("HEEERE");
    for (String person in data['owe'].keys) {
      if (person != UserStore.uid) {
        //updating the individual user profiles
        await uc.doc(person).update({
          'friends.${UserStore.uid}.activity':
              FieldValue.arrayUnion([data['expenseID']]),
          'friends.${UserStore.uid}.owe':
              FieldValue.increment(data['owe'][person] * -1),
          'activity': FieldValue.arrayUnion([data['expenseID']]),
          'groups.$person.owe': FieldValue.increment(-1 * data['owe'][person]),
        });
        ttt['friends.$person.activity'] =
            FieldValue.arrayUnion([data['expenseID']]);
        ttt['friends.$person.owe'] = FieldValue.increment(data['owe'][person]);
      }
    }

    //Update profile of current user
    await uc.doc(UserStore.uid).update(ttt);

    CollectionReference clrf = getColl('groups');
    Map<String, dynamic> input = {
      'expenses': FieldValue.arrayUnion([data['expenseID']]),
    };

    for (String person in data['owe'].keys) {
      if (person != UserStore.uid) {
        await clrf.doc(person).update({
          'expenses': FieldValue.arrayUnion([data['expenseID']]),
          'balances.$person.${UserStore.uid}':
              FieldValue.increment(data['owe'][person] * -1),
        });
        input['balances.${UserStore.uid}.$person'] =
            FieldValue.increment(data['owe'][person]);
      }
    }

    await clrf.doc(UserStore.uid).update(input);
    return "Success";
  }

  Future<List<ExpenseModel>> getFriendExpenses(String friend) async {
    CollectionReference clrf = getColl('expenses');
    List<ExpenseModel> e = [];
    for (String x in UserStore.friends[friend]!.activity) {
      DocumentSnapshot data2 = await clrf.doc(x).get();
      var resp2 = data2.data()! as Map<String, dynamic>;
      e.add(ExpenseModel.fromJson(resp2));
    }

    return e;
  }

  Future<List<ExpenseModel>> getActivity()
  async {

    CollectionReference clrf = getColl('expenses');
    List<ExpenseModel> e = [];
    for (String x in UserStore.activity) {
      DocumentSnapshot data2 = await clrf.doc(x).get();
      var resp2 = data2.data()! as Map<String, dynamic>;
      e.add(ExpenseModel.fromJson(resp2));
    }
    return e;

  }
}
