import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/stores/mapping_store.dart';

import '../stores/user_store.dart';

class StorageMtds
{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String uid = UserStore.uid;

  uploadPost({required String path, required Uint8List file}) async
  {
    Reference ref = _storage.ref();
    ref = ref.child('dp').child(uid);

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    await FireStrMtd().updateDP(downloadUrl);
    MappingStore.dp[UserStore.uid] = downloadUrl;
    return downloadUrl;
  }

  deleteDp() async
  {
    Reference reference = _storage.ref().child('dp/'+uid);
    await reference.delete();
  }

}