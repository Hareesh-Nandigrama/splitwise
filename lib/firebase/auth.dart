import 'package:firebase_auth/firebase_auth.dart';
import 'firestore.dart';

class AuthMtds {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  inst() {
    return _auth;
  }


  getUid()
  {
    if(_auth.currentUser == null)
    {
      return "";
    }
    return _auth.currentUser?.uid;
  }



  getEmail()
  {
    if(_auth.currentUser == null)
      {
        return "";
      }
    return _auth.currentUser?.email;
  }


  Future<bool> checkEmailExists(String email) async {
    bool response = false;
    try {
      List<String> ans = await _auth.fetchSignInMethodsForEmail(email);
      if (ans.isNotEmpty) {
        response = true;
      }
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }

    return response;
  }

  checkCurrentPassword(String pass) async {
    User user = _auth.currentUser!;
    AuthCredential credential = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!, password: pass);
    print('Password validation initiated');
    try {
      await user.reauthenticateWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> createUser(
      {required String email,
      required String password,
      required String username,
      required String phoneNumber}) async {
    String reply = '';
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = cred.user!.uid;
      await FireStrMtd().createUser(
          email: email, uid: uid, username: username, phoneNumber: phoneNumber);
      reply = 'Success';
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      if (e.code == 'invalid-email') {
        reply = 'Enter Vaild Mail';
      } else if (e.code == 'weak-password') {
        reply = 'Password should be atleast 6 characters';
      } else if (e.code == 'email-already-in-use') {
        reply = 'This Mail is already in use';
      } else if (e.code == 'unknown') {
        reply = 'Please fill all details';
      } else {
        reply = e.toString();
      }
    }
    return reply;
  }

  Future<String> loguser(
      {required String email, required String password}) async {
    String reply = '';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      reply = 'Success';
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      if (e.code == 'invalid-email') {
        reply = 'Enter Vaild Mail';
      } else if (e.code == 'wrong-password') {
        reply = 'Invalid Credentials';
      } else if (e.code == 'user-not-found') {
        reply = 'Account does not exist';
      } else if (e.code == 'unknown') {
        reply = 'Please fill all details';
      } else if (e.code == 'too-many-requests') {
        reply = 'Too many requests, try again later';
      } else {
        reply = e.toString();
      }
    }
    return reply;
  }

  Future<String> logout() async {
    try {
      print('Request for user sign out');
      await _auth.signOut();
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }
}
