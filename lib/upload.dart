import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mba_its_mine/add_password.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mba_its_mine/homepage.dart';
import 'package:mba_its_mine/main.dart';


class Upload extends StatefulWidget {
  const Upload({Key? key, required this.name, required this.description,required this.uuid, required this.password, required this.pictureList}) : super(key: key);

  final String name;
  final String description;
  final String uuid;
  final String password;
  final List<XFile> pictureList;

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  int? uploadSent = 0;
  int? uploadTotal = 1;
  bool? isUploadFinished = false;

  void _upload() async {

    FormData data = FormData.fromMap({
      "data": '{"name":"${widget.name}","info":"${widget.description}","uuid": "${widget.uuid}", "password":"${widget.password}"}',
      'files.images': [
        for (var i = 0; i < widget.pictureList.length; i++)
          await MultipartFile.fromFile(widget.pictureList[i].path,
              filename: widget.pictureList[i].path.split('/').last)
      ]
    });

    Dio dio = new Dio();

    dio.post("https://itsmineapi.herokuapp.com/nfc-objects", data: data ,options: Options(contentType: 'multipart/form-data'),onSendProgress: (int sent, int total) {
      print('$sent $total');
      setState(() {
        uploadSent = sent;
        uploadTotal = total;
      });
    }).then((response) {
      print(response.statusCode);
      setState(() {
        isUploadFinished = true;
      });
    }).catchError((error) => print(error));
  }


  @override
  void initState() {
    super.initState();
    if(mounted){
      _upload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // 1
          title: const Text(
            'Sauvegarder',
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
            child: isUploadFinished == false ?
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("C'est bientot fini !"),

                  SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        value: (uploadSent!/uploadTotal!).toDouble(),
                        minHeight: 20,
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.teal),
                        backgroundColor: Colors.grey[200],
                      )
                  ),
                  Text("Envoi des images sur le serveur ...")
                ],
              ),
            ) :
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bravo !"),
                  Text("${widget.name} est maintenant enregistré"),
                  SizedBox(
                    width: 200,
                      child: LinearProgressIndicator(
                        value: 100,
                        minHeight: 20,
                      )
                  ),
                  Text("Tout est ok, collez votre tag sur un objet et le tour est joué !"),
                  MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('Voir mes objets'),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => const MyHomePage(title: "It's mine"),
                          ),
                              (route) => false,//if you want to disable back feature set to false
                        );
                      }
                  )

                ],
              ),
          )
        )
    );
  }
}