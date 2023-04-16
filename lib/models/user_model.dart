import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? email;
  final String? uid;
  final String? firstname;
  final String? lastname;
  final String? photoUrl;

  UserModel({
    required this.photoUrl,
    required this.uid,
    required this.email,
    required this.lastname,
    required this.firstname,
  });

  Map<String, dynamic> toJason() => {
    'firstname': firstname,
    'email': email,
    'lastname': lastname,
    'uid': uid,
    'photoUrl': photoUrl,
  };


  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      photoUrl: snapshot['photoUrl'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      firstname: snapshot['firstname'],
      lastname: snapshot['lastname'],
    );

  }

}