import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mba_its_mine/add_password.dart';
import 'package:http_parser/http_parser.dart';


class AddPictures extends StatefulWidget {
  const AddPictures({Key? key, required this.name, required this.description}) : super(key: key);

  final String name;

  final String description;

  @override
  State<AddPictures> createState() => _AddPicturesState();
}

class _AddPicturesState extends State<AddPictures> {

  XFile? file;
  List<XFile> pictureList = [];

  void _choose() async {
    file = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      pictureList.add(file!);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // 1
        title: const Text(
          'Ajouter un objet',
          style: TextStyle(
          color: Colors.black, // 2
          ),
        ),
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: MaterialButton(
            color: Color(0xff6c5ce7),
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
            child: Text('retour'),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))
            )
          ),
        ),
      ),
        // resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.looks_3,
                      color: Color(0xff6c5ce7),
                      size: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text("Ajouter des photos de l'objet", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      children: [
                    pictureList.isNotEmpty ?
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8),
                        itemCount: pictureList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            height: 100,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(File(pictureList[index]!.path)),
                                fit: BoxFit.cover
                              )
                            ),
                          );
                        }
                  ),
                    ): Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/150")
                            )
                          ),
                        )),
                        MaterialButton(
                            color: Color(0xff6c5ce7),
                            textColor: Colors.white,
                            child: Text('Prendre en photo'),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8.0))
                            ),
                            onPressed: () => _choose()
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Etape 2/3', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    MaterialButton(
                        color: Color(0xff6c5ce7),
                        textColor: Colors.white,
                        child: Text('Suivant'),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0))
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddPassword(name: widget.name, description: widget.description, pictureList: pictureList)),
                          );
                        }
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}