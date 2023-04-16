import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduka/models/user_model.dart';
import 'package:eduka/providers/user_provider.dart';
import 'package:eduka/utils/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/cource_model.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> UploadCource(
      String tittle,
      String discription,
      File videourls,
      Uint8List thumbnail,
      String val,
      String name,
      String certification,
      String time,) async {
    String ref = 'Something went wrong';
    try {

      print('Firestore method');
      print(tittle);
      print(discription);
      print('Uploading Started in firestore');
      String id = const Uuid().v1();

      final thubnailUrl = await StorageMethod()
          .uploadImageToStorage('tumbnail/', thumbnail);

      final videoUrl = await StorageMethod()
          .UploadVideoToStorage('cource/', videourls);

      print('Uploading completed storage');

      final user = CourceModel(
        tittle: tittle,
        discription: discription,
        videoUrl: videoUrl,
        id: id,
        uid: _auth.currentUser!.uid,
        category: val,
        tags: [],
        enrolls: [],
        thubnailUrl: thubnailUrl,
        name: name,
        certification: certification,
        time: time,
      );

      await _firestore.collection('cources').doc(id).set(user.toJason());

      ref = 'Success';
    } on FirebaseException catch (err) {
      ref = err.message.toString();
    }

    return ref;
  }

  void EnrollCource(String uid, String id) async {
    try {
      await _firestore.collection('cources').doc(id).update({
        'enrolls': FieldValue.arrayUnion([uid])
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
