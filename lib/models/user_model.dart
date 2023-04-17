import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? email;
  final String? uid;
  final String? firstname;
  final String? lastname;
  final String? photoUrl;
  final int? courses;
  final int? enrols;

  UserModel({
    required this.photoUrl,
    required this.uid,
    required this.enrols,
    required this.courses,
    required this.email,
    required this.lastname,
    required this.firstname,
  });

  Map<String, dynamic> toJason() => {
    'firstname': firstname,
    'email': email,
    'enrols': enrols,
    'courses': courses,
    'lastname': lastname,
    'uid': uid,
    'photoUrl': photoUrl,
  };


  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      photoUrl: snapshot['photoUrl'],
      uid: snapshot['uid'],
      enrols: snapshot['enrols'],
      email: snapshot['email'],
      firstname: snapshot['firstname'],
      courses: snapshot['courses'],
      lastname: snapshot['lastname'],
    );

  }

}