import 'package:flutter/material.dart';

class Text1 extends StatelessWidget {
  IconData icon;
  String text;

  Text1({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 20),
        Text(text , style: TextStyle(fontWeight: FontWeight.bold  , fontSize: 20),),
      ],
    );
  }
}
