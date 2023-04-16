import 'package:eduka/screens/play_video_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/firestore_methods.dart';
import '../widgets/text1.dart';

class CourceOpenScreen extends StatefulWidget {
  final snap;

  CourceOpenScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<CourceOpenScreen> createState() => _CourceOpenScreenState();
}

class _CourceOpenScreenState extends State<CourceOpenScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool? isThere;


  @override
  void initState() {
    super.initState();
    check();
  }

  void check() async {
    setState(() {
      isThere = widget.snap['enrolls'].contains(_auth.currentUser!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 280,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.snap['thubnailUrl']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 280,
                decoration: const BoxDecoration(
                  color: Color(0x79020000),
                ),
              ),
              Positioned(
                left: 40,
                top: 60,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.snap['tittle'],
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 900,
                        padding: EdgeInsets.only(right: 30),
                        child: Text(
                          widget.snap['discription'],
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This cource includes:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text1(
                          icon: Icons.account_circle,
                          text: widget.snap['certification'] != null ? widget.snap['certification'] : "",
                        ),
                        SizedBox(width: 40),
                        Text1(
                          icon: Icons.account_circle,
                          text: widget.snap['time'],
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Text1(
                          icon: Icons.account_circle,
                          text: widget.snap['category'],
                        ),
                      ],
                    ),
                  ],
                ),
                MaterialButton(
                  onPressed: () {
                    print(isThere);
                    if (isThere!) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => PlayVideoScreen(
                                uil: widget.snap['videoUrl'].toString(),
                              )),
                        ),
                      );
                    } else {
                      FirestoreMethods().EnrollCource(_auth.currentUser!.uid, widget.snap['id']);
                    }
                  },
                  child: Text(isThere == true ? 'PLAY' : "ENROLL"),
                  color: Colors.blueAccent,
                  minWidth: 300,
                  height: 60,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
