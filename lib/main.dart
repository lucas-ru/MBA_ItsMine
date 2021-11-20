import 'dart:convert';
import 'dart:html';
import 'dart:html';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mba_its_mine/image.dart';
import 'package:dio/dio.dart';
import 'package:mba_its_mine/homepage.dart';

Future main() async{
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "It's mine"),
      debugShowCheckedModeBanner: false,
    );
  }
}

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
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

  @override
  void initState() {
    super.initState();
    fetchImage();
    uploadData("stiti","informatique","150280","keyword","lucas","lucas");
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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

