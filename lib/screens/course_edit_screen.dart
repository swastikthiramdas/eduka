import 'dart:typed_data';

import 'package:eduka/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CourseEditScreen extends StatefulWidget {
  const CourseEditScreen({Key? key}) : super(key: key);

  @override
  State<CourseEditScreen> createState() => _CourseEditScreenState();
}

class _CourseEditScreenState extends State<CourseEditScreen> {
  Uint8List? _RawVideo;
  Uint8List? _RawThubnail;


  void selectVideo(BuildContext context) async {
    Uint8List? file = await pickDiffrentVideo(ImageSource.gallery);
    setState(() {
      _RawVideo = file;
    });
  }

  void selectThubnail() async {
    Uint8List file = await pickImage(ImageSource.gallery);
    setState(() {
      _RawThubnail = file;
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
 /*         SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Upload Your Course',
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
                      decoration: const InputDecoration(
                        hintText: 'Tittle',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Discription',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
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
                    const SizedBox(height: 20),
                    *//*,*//*
                    SizedBox(
                      height: 170,
                      width: 800,
                      child: IconButton(
                        onPressed: () => selectVideo(context),
                        icon: Icon(
                          Icons.cloud_upload_rounded,
                          color: _RawVideo != null
                              ? Colors.blueAccent
                              : Colors.black,
                          size: 80,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: _RawVideo != null ? 200 : 350,
                          child: MaterialButton(
                            color: Colors.blueAccent,
                            minWidth: double.maxFinite,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            onPressed: () => upload(),
                            child: const Text('Puch'),
                          ),
                        ),
                        _RawVideo != null
                            ? SizedBox(
                          width: 100,
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                _RawVideo = null;
                              });
                            },
                            child: Center(
                              child: Text('CANCEL'),
                            ),
                          ),
                        )
                            : SizedBox()
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: circularVisilbel,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )*/
        ],
      ),
    );
  }
}
