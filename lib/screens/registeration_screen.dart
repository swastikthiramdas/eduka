import 'dart:io';
import 'dart:typed_data';
import 'package:eduka/screens/home_page.dart';
import 'package:eduka/utils/auth_methords.dart';
import 'package:eduka/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _email = TextEditingController();
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _password = TextEditingController();
  final _conformpassword = TextEditingController();
  final bool isLoding = false;
  Uint8List? _image;
  bool conformPassword = true;
  bool password = true;
  final auth = FirebaseAuth.instance;
  String img =
      'https://firebasestorage.googleapis.com/v0/b/new-project-6e5b9.appspot.com/o/default-profile-icon-16.jpg?alt=media&token=c05018f2-ee0b-4ef3-a12f-31125ccc5aea';

  void selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _conformpassword.dispose();
    _password.dispose();
    _email.dispose();
    _lastname.dispose();
    _firstname.dispose();
  }

  void signUpUser() async {
    if (_lastname.text.trim().isNotEmpty &&
        _firstname.text.trim().isNotEmpty &&
        _email.text.trim().isNotEmpty &&
        _password.text.trim().isNotEmpty &&
        _conformpassword.text.trim().isNotEmpty && _image != null) {
      print(_firstname.text);
      print(_lastname.text);
      print(_email.text);
      print(_password.text);
      print(_conformpassword.text);

      if (_password.text == _conformpassword.text) {
        String ref = await AuthMethods().signUpUser(
          email: _email.text.toLowerCase(),
          password: _password.text,
          firstname: _firstname.text,
          lastname: _lastname.text,
          photo: _image!,
        );

        showSnakBar(ref, context);
        if (ref == 'Success') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
      } else {
        showSnakBar('Passwords are not similar', context);
      }
    } else {
      showSnakBar('Enter details', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*backgroundColor: Color(0x6988FAFF),*/
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 400,
            height: 800,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(blurRadius: 1, spreadRadius: 0.10),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Register',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 50, backgroundImage: MemoryImage(_image!))
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(img),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 70,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(
                          Icons.add_a_photo_rounded,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: 350,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _firstname,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      hintText: 'First Name',
                      hintStyle: TextStyle(fontSize: 12),
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 350,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 0.5)),
                  child: TextField(
                    controller: _lastname,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      hintText: 'Last Name',
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 350,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 0.5)),
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 350,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 0.5)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _password,
                          obscureText: password,
                          decoration: InputDecoration(
                            icon: Icon(Icons.key),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              password = !password;
                            });
                          },
                          icon: Icon(Icons.remove_red_eye))
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 350,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _conformpassword,
                          obscureText: conformPassword,
                          decoration: InputDecoration(
                            icon: Icon(Icons.key),
                            hintText: 'Conform Password',
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              conformPassword = !conformPassword;
                            });
                          },
                          icon: Icon(Icons.remove_red_eye))
                    ],
                  ),
                ),
                SizedBox(height: 40),
                MaterialButton(
                  splashColor: Colors.lightBlueAccent,
                  minWidth: 350,
                  height: 60,
                  onPressed: () {
                    print('click is working');
                    signUpUser();
                  },
                  child: Text('SIGN UP'),
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
