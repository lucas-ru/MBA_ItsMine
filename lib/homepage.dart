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