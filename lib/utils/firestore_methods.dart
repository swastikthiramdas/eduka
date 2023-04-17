import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduka/utils/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../models/cource_model.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;



  Future<String> UpdatePersonalInfo(String id , String firstname , String lastname , String email ,String profUrl ) async {
    String ref = "Something went wrong";
    try{

      if (profUrl.trim().isNotEmpty) {
        await _firestore.collection('users').doc(id).update({'photoUrl' : profUrl});
      }
      
      if (firstname.trim().isNotEmpty) {
        await _firestore.collection('users').doc(id).update({'firstname' : firstname});
      }

      if (firstname.trim().isNotEmpty) {
        await _firestore.collection('users').doc(id).update({'lastname' : lastname});
      }

      if (firstname.trim().isNotEmpty) {
        await _firestore.collection('users').doc(id).update({'email' : email});
      }

      ref = "Success";

    }
    on FirebaseException catch(e){
      ref = e.message.toString();
    }

    return ref;
  }





  Future<String> UploadCource(
      String tittle,
      String discription,
      Uint8List videourls,
      Uint8List thumbnail,
      String val,
      String name,
      String certification,
      String time,
      int course) async {
    String ref = 'Something went wrong';
    try {

      print('Firestore method');
      print(tittle);
      print(discription);
      print('Uploading Started in firestore');
      String id = Uuid().v4();

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

      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({'courses' : course + 1});
      ref = 'Success';
    } on FirebaseException catch (err) {
      ref = err.message.toString();
    }

    return ref;
  }

  void EnrollCource(String uid, String id , int courese) async {
    try {
      await _firestore.collection('cources').doc(id).update({
        'enrolls': FieldValue.arrayUnion([uid])
      });


      await _firestore.collection('users').doc(uid).update({
        'enrols': courese + 1});



    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
