import 'dart:io';
import 'dart:typed_data';

import 'package:eduka/models/user_model.dart';
import 'package:eduka/utils/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> getUser() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return UserModel.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required Uint8List photo,
  }) async {
    String res = 'Some error occurred';

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final ImageUrl = await StorageMethod()
          .uploadImageToStorage('profilePic/', photo);

      final String uid = await cred.user!.uid;

      final user = UserModel(
        uid: uid,
        firstname: firstname,
        photoUrl: ImageUrl,
        lastname: lastname,
        email: email,
      );

      await _firestore.collection('users').doc(uid).set(user.toJason());
      res = 'Success';
    } on FirebaseAuthException catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String ref = 'Something went wrong';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        ref = 'Success';
      } else {
        ref = 'Enter Details';
      }
    } catch (err) {
      ref = err.toString();
    }
    return ref;
  }
}
