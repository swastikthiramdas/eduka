import 'package:flutter/material.dart';

class ProfileText extends StatelessWidget {
  final String cat;
  final String data;
  const ProfileText({Key? key, required this.cat, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Text("${cat} :", style: TextStyle(fontSize: 16 , color: Colors.black , fontWeight: FontWeight.bold),),
          SizedBox(width: 10),
          Text(data ,  style: TextStyle(fontSize: 16 , color: Colors.black , fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
