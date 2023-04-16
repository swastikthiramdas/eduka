import 'dart:io';
import 'dart:typed_data';
import 'package:eduka/models/user_model.dart';
import 'package:eduka/providers/user_provider.dart';
import 'package:eduka/utils/firestore_methods.dart';
import 'package:eduka/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _tittleController = TextEditingController();
  final _certification = TextEditingController();
  final _time = TextEditingController();
  bool circularVisilbel = false;
  final _discriptionController = TextEditingController();

  String? name;
  File? _RawVideo;
  Uint8List? _RawThubnail;

  final List<String> CatList = [
    'python',
    'web development',
    'java script',
    'android development',
  ];

  String val = 'python';

  void selectVideo(BuildContext context) async {
    File? file = await pickDiffrentVideo(context);
    setState(() {
      _RawVideo = file;
    });
  }

  void selectThubnail() async {
    // File? im = await pickVideo(context);
    Uint8List file = await pickImage(ImageSource.gallery);
    setState(() {
      _RawThubnail = file;
    });
  }

  void upload() async {
    print(_tittleController.text);
    print(_discriptionController.text);
    // print(name);

    if (_tittleController.text.trim().isNotEmpty &&
        _discriptionController.text.trim().isNotEmpty &&
        _time.text.trim().isNotEmpty &&
        name!.trim().isNotEmpty &&
        _certification.text.trim().isNotEmpty) {
      setState(() {
        circularVisilbel = true;
      });
      print('upload to start');
      print(_tittleController.text);
      print(_discriptionController.text);

      String ref = await FirestoreMethods().UploadCource(
          _tittleController.text,
          _discriptionController.text,
          _RawVideo!,
          _RawThubnail!,
          val,
          name!,
          _certification.text.trim(),
          _time.text.trim());

      setState(() {
        circularVisilbel = false;
      });

      showSnakBar(ref, context);
      showSnakBar('Complete', context);

      if (ref == 'Success') {
        Navigator.pop(context);
      }
    } else {
      showSnakBar('Something went wrong', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserModel _user = Provider.of<UserProvider>(context).getUser;
    name = _user.firstname;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Upload Your Cource',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () => selectThubnail(),
                          child: Container(
                            height: 170,
                            decoration: _RawThubnail == null
                                ? BoxDecoration(
                                    color: Colors.redAccent,
                                  )
                                : BoxDecoration(
                                    image: DecorationImage(
                                        image: MemoryImage(_RawThubnail!),
                                        fit: BoxFit.cover),
                                  ),
                            child: const Center(
                              child: Icon(Icons.add_circle),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _tittleController,
                          decoration: const InputDecoration(
                            hintText: 'Tittle',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _discriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Discription',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _certification,
                          decoration: const InputDecoration(
                            hintText: 'Certification',
                          ),
                        ),
                        const SizedBox(height: 10),
                        DropdownButton<String>(
                          isExpanded: true,
                          value: val,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              val = value!;
                            });
                          },
                          items: CatList.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _time,
                          decoration: const InputDecoration(
                            hintText: 'Time',
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 170,
                    width: 800,
                    child: InkWell(
                      onTap: () => selectVideo(context),
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add_circle,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _RawVideo != null
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              _RawVideo = null;
                            });
                          },
                          child: const Text(
                            'Click hear to deselect video',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : SizedBox(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    child: MaterialButton(
                      color: Colors.blueAccent,
                      minWidth: double.maxFinite,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      onPressed: () => upload(),
                      child: const Text('Puch'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Visibility(
            visible: circularVisilbel,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
