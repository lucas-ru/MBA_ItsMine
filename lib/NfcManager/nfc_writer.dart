
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:mba_its_mine/object_profile.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;



class NfcWriter extends StatefulWidget {
  const NfcWriter({Key? key, required this.name, required this.description, required this.path, required this.password}) : super(key: key);

  final String name;

  final String description;

  final XFile? path;

  final String password;

  @override
  State<StatefulWidget> createState() => NfcWriterState();
}

class NfcWriterState extends State<NfcWriter> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  final Url_API = dotenv.env['URL_API'];

  Future<http.Response> uploadData(String name, String info, String uuid, String password, String created_by, String updated_by) {
    return http.post(
      Uri.parse(Url_API!),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'info': info,
        'uuid': uuid,
        'password': password,
        'created_by': created_by,
        'updated_by': updated_by,
      }),
    );
  }


  void _upload(XFile file) async {
    String fileName = file.path.split('/').last;
    print(fileName);

    FormData data = FormData.fromMap({
      "ref": "nfc-object",
      "refId": "3",
      "files": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "field": "images"
    });


    Dio dio = new Dio();

    dio.post("https://itsmineapi.herokuapp.com/upload/", data: data).then((response) {
      var jsonResponse = jsonDecode(response.toString());
      var testData = jsonResponse['histogram_counts'].cast<double>();
      var averageGrindSize = jsonResponse['average_particle_size'];
    }).catchError((error) => print(error));
  }

  @override
  void initState() {
    _ndefWrite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Sauvegarder",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: NfcManager.instance.isAvailable(),
          builder: (context, ss) => ss.data!= true
              ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
              : Flex(
            mainAxisAlignment: MainAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              SizedBox(height: 100,),
              Flexible(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  constraints: BoxConstraints.expand(),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffa29bfe),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.white
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/nfc.png")
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Flexible(
                  flex: 2,
                  child:Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text("Approchez un tag NFC vierge pour sauvegarder les données",style: TextStyle(fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ObjectProfile()),
      );
    });
  }

  void _ndefWrite() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: result.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createText('uid'),
      ]);

      try {
        await ndef.write(message);
        result.value = 'Success to "Ndef Write"';
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }




}