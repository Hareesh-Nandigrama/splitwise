import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:splitwise/firebase/auth.dart';

class FireStrMtd
{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  getColl(String name) {return _firestore.collection(name);}

  createUser({required String email, required String uid, required String username, required String phoneNumber}) async
  {
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

  addFriend({required String email})
  async {
    if(await AuthMtds().checkEmailExists(email))
      {
        CollectionReference users = FirebaseFirestore.instance.collection('users');
         var doc = await users.doc('e@gmail.com').get();
         var resp = doc.data()! as Map<String, dynamic>;
         print(resp['friends']);
       // List<String> resp = doc.get('friends');
       //  if(resp.contains(email))
       //    {
       //      print("Already friend");
       //    }
       //  else
       //    {
       //      print("Adding to friend");
       //    }
      }
    else
      {
        return "Invalid Email";
      }

  }

  saveUserData(String email) async
  {
    DocumentSnapshot data = await _firestore.collection('users').doc(email).get();
    var resp = data.data()! as Map<String, dynamic>;

    String dbPath = 'sample.db';
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbPath);
    var store = StoreRef.main();
    await store.record('userdata').put(db,
    {
      'email': resp['email'],
      'username': resp['username'],
      'phoneNumber': resp['phoneNumber'],
      'friends': resp['friends'],
      'groups': resp['groups'],
    }
    );

  }


}