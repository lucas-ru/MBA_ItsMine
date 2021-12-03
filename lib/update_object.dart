import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mba_its_mine/add_pictures.dart';
import 'package:mba_its_mine/homepage.dart';
import 'image.dart';
import 'package:http/http.dart' as http;


class UpdateObject extends StatefulWidget {
  const UpdateObject({Key? key, required this.object}) : super(key: key);

  final Object object;

  @override
  State<UpdateObject> createState() => _UpdateObjectState();
}

class _UpdateObjectState extends State<UpdateObject> {
  final Url_API = dotenv.env['URL_API'];

  TextEditingController controller = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      controller.text = widget.object.name!;
      controller2.text = widget.object.info!;
    });
  }

  Future<http.Response> uploadData(String name, String info, String uuid) {
    return http.put(
      Uri.parse("$Url_API/${widget.object.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'info': info,
        'uuid': uuid,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // 1
          title: const Text(
            'Modifier un objet',
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
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: Colors.black),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
        ),
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Align(child: Text("Nom de l'objet"), alignment: Alignment.topLeft,),
                            TextFormField(
                              controller: controller,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          children: [
                            const Align(child: Text("Information en cas de perte"), alignment: Alignment.topLeft,),
                            TextFormField(
                              controller: controller2,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              minLines: 3,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                              color: Color(0xff6c5ce7),
                              textColor: Colors.white,
                              child: Text('Modifier'),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8.0))
                              ),
                              onPressed: () {
                                uploadData(controller.value.text, controller2.value.text, "${widget.object.uuid}");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MyHomePage(title: "It's mine",)),
                                );
                              }
                          )
                        ],
                      )
                    ],
                  ),
                )
            ),
          ),
        )
    );
  }
}