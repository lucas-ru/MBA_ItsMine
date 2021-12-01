import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mba_its_mine/NfcManager/nfc_writer.dart';

import 'NfcManager/nfc_reader.dart';
import 'object_profile.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'add_object.dart';
import 'image.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final Url_API = dotenv.env['URL_API'];

  Future<FormData> FormData1(String Path, String nameImage) async {
    return FormData.fromMap({
      'images': [
        await MultipartFile.fromFile(
          Path,
          filename: nameImage,
        ),
      ]
    });
  }

  Future<FormData> FormData2(String name, String info, String uuid, String password, String created_by, String updated_by, String Path, String nameImage) async {
    return FormData.fromMap({
      'name': name,
      'info': info,
      'uuid': uuid,
      'password': password,
      'created_by': created_by,
      'updated_by': updated_by,
      'images': [
        await MultipartFile.fromFile(
          Path,
          filename: nameImage,
        ),
      ]
    });
  }

  Future<List<Object>> fetchImage() async {
    final response = await http
        .get(Uri.parse(Url_API!));
    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return List<Object>.from(jsonDecode(response.body).map((i) => Object.fromJson(i)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Object');
    }
  }




  late String uploadURL;

  // Upload(imageFile) async {
  //   var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  //   var length = await imageFile.length();
  //
  //   var uri = Uri.parse(uploadURL);
  //
  //   var request = new http.MultipartRequest("POST", uri);
  //   var multipartFile = new http.MultipartFile('file', stream, length,
  //       filename: basename(imageFile.path));
  //   //contentType: new MediaType('image', 'png'));
  //
  //   request.files.add(multipartFile);
  //   var response = await request.send();
  //   print(response.statusCode);
  //   response.stream.transform(utf8.decoder).listen((value) {
  //     print(value);
  //   });
  // }
  //

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

  // From path
  Future<String?> uploadImage(filename) async {
    var request = http.MultipartRequest('POST', Uri.parse(Url_API!));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }

  // From Bytes
  // Future<String> uploadImageBytes(filepath, url) async {
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.files.add(
  //       http.MultipartFile.fromBytes(
  //           'picture',
  //           File(filepath).readAsBytesSync(),
  //           filename: filepath.split("/").last
  //       )
  //   );
  //   var res = await request.send();
  // }

  // with dio
  // possible to send FormData2
  Future<String?> uploadImageDio(filename) async {
    var dio = Dio();
    Response response;

    response = await dio.post(
      //"/upload",
      Url_API!,
      data: await FormData1("path1","nom1"),
      onSendProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + '%');
        }
      },
    );
    print(response);
  }

  void _choose() async {
    XFile? file;
    file = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (file != null) {
      //haveImg = true;
      _upload(file);
      setState(() {});
    }
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
    super.initState();
    fetchImage();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xff6c5ce7),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddObject()),
          );
        },
        label: Text("Ajouter un objet"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
        ),

      ),
      body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${widget.title}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 2, color: Color(0xffa29bfe)) ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NfcReader()),
                          );
                        },
                        child: Text("Scanner un objet",style: TextStyle(color: Color(0xff6c5ce7)),))
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Mes objets")),
              ),
              Expanded(
                  child: FutureBuilder<List<Object>>(
                    future: fetchImage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return  GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            children: snapshot.data!.map((e) => ItemListImg(img: e)).toList()
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      // By default, show a loading spinner.
                      return const Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator());
                    },
                  )
              )],
          )
      ),
    );
  }
}

class ItemListImg extends StatelessWidget {

  final Object img;

  const ItemListImg (
      { required this.img }
      ) : super();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ObjectProfile(uuid: img.uuid,)),
        )
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              height: 100,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  image: img.images!.isNotEmpty ?
                  DecorationImage(
                      image: NetworkImage("${img.images![0].url}"),
                      fit: BoxFit.cover
                  ):
                  const DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/150"),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Text('${img.name}')
          ],
        ),
      ),
    );
  }}