import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List? file) async {
    Reference ref;
    TaskSnapshot snap;

    String id = Uuid().v4();

    ref = await _storage
        .ref()
        .child(childName)
        .child(_auth.currentUser!.uid)
        .child(id);
    UploadTask uploadTask = ref.putData(file!);
    snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> UploadVideoToStorage(
      String childName, Uint8List? videofile) async {
    final metaData;

    Reference ref;
    TaskSnapshot snap;
    String id = Uuid().v4();

    metaData = SettableMetadata(contentType: 'video/mp4');
    ref = await _storage
        .ref()
        .child(childName)
        .child(_auth.currentUser!.uid)
        .child(id);
    UploadTask uploadTask = ref.putData(videofile!, metaData);
    snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
