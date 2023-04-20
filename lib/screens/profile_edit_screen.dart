import 'dart:typed_data';
import 'package:eduka/utils/firestore_methods.dart';
import 'package:eduka/utils/storage_methods.dart';
import 'package:eduka/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';


class ProfileEditScreen extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String email;
  final String url;
  final String id;

  ProfileEditScreen({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.url,
    required this.id,
  }) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fisrnameController = TextEditingController();
  TextEditingController _lstnameController = TextEditingController();

  String? firstname;
  String? lastname;
  String? email;
  Uint8List? _pictuew;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
    _fisrnameController.text = widget.firstname;
    _lstnameController.text = widget.lastname;

  }


  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
    return "Done";
  }


  void updateValues() async {
    if (_emailController.text.trim().isNotEmpty &&
        _fisrnameController.text.trim().isNotEmpty &&
        _lstnameController.text.trim().isNotEmpty) {
      String ref = "Change your details";
      if (_pictuew != null) {
        String url =
            await StorageMethod().uploadImageToStorage("profilePic/", _pictuew);
        ref = await FirestoreMethods()
            .UpdatePersonalInfo(widget.id, '', '', '', url);
      }

      if (widget.lastname.trim() != _lstnameController.text.trim()) {
        ref = await FirestoreMethods().UpdatePersonalInfo(
            widget.id, "", _lstnameController.text.trim(), "", "");
      }

      if (widget.firstname.trim() != _fisrnameController.text.trim()) {
        ref = await FirestoreMethods().UpdatePersonalInfo(
            widget.id, _fisrnameController.text.trim(), "", "", "");
      }

      if (widget.email != _emailController.text.trim()) {
        ref = await FirestoreMethods().UpdatePersonalInfo(
            widget.id, "", "", _emailController.text.trim(), "");
      }

      addData();
      if (ref == "Success") {
        Navigator.of(context).pop(context);
      } else {
        showSnakBar(ref, context);
      }
    }
  }

  void selectPhoto() async {
    // File? im = await pickVideo(context);
    Uint8List file = await pickImage(ImageSource.gallery);
    setState(() {
      _pictuew = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.cancel),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () => updateValues(),
                            icon: Icon(Icons.check),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        children: [
                          _pictuew != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: MemoryImage(_pictuew!))
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(widget.url),
                                ),
                          Positioned(
                            bottom: -10,
                            left: 70,
                            child: IconButton(
                              onPressed: () => selectPhoto(),
                              icon: Icon(
                                Icons.add_a_photo_rounded,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _fisrnameController,
                      decoration: const InputDecoration(
                        hintText: 'Firstname',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _lstnameController,
                      decoration: const InputDecoration(
                        hintText: 'Lastname',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
