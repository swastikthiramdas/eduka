import 'package:cloud_firestore/cloud_firestore.dart';

class CourceModel {
  final String tittle;
  final String category;
  final List tags;
  final List? enrolls;
  final String id;
  final String certification;
  final String time;
  final String uid;
  final String discription;
  final String name;
  final String videoUrl;
  final String thubnailUrl;

  CourceModel({
    required this.category,
    required this.certification,
    required this.time,
    required this.tags,
    required this.enrolls,
    required this.name,
    required this.tittle,
    required this.discription,
    required this.videoUrl,
    required this.thubnailUrl,
    required this.id,
    required this.uid,
  });

  Map<String, dynamic> toJason() => {
        'id': id,
        'category': category,
        'certification': certification,
        'time': time,
        'tags': tags,
        'thubnailUrl': thubnailUrl,
        'enrolls': enrolls,
        'name': name,
        'uid': uid,
        'videoUrl': videoUrl,
        'discription': discription,
        'tittle': tittle,
      };

  static CourceModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CourceModel(
      videoUrl: snapshot['videoUrl'],
      certification: snapshot['certification'],
      time: snapshot['time'],
      thubnailUrl: snapshot['thubnailUrl'],
      category: snapshot['category'],
      name: snapshot['name'],
      tags: snapshot['tags'],
      enrolls: snapshot['enrolls'],
      id: snapshot['id'],
      uid: snapshot['uid'],
      discription: snapshot['discription'],
      tittle: snapshot['tittle'],
    );
  }
}
