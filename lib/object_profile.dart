import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'homepage.dart';
import 'image.dart';



class ObjectProfile extends StatefulWidget {
  const ObjectProfile({Key? key, this.uuid}) : super(key: key);
  final String? uuid;

  @override
  State<ObjectProfile> createState() => _ObjectProfileState();
}

class _ObjectProfileState extends State<ObjectProfile> {

  final Url_API = dotenv.env['URL_API'];

  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  Future<List<Object>> fetchImage() async {
    final response = await http
        .get(Uri.parse("$Url_API?uuid=${widget.uuid}"));
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
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // 1
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
        body:  FutureBuilder<List<Object>>(
                    future: fetchImage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return  ObjectInfo(img: snapshot.data![0]);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      // By default, show a loading spinner.
                      return const Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator());
                    },
                  ));
  }
}

class ObjectInfo extends StatelessWidget {

  final Object img;

  const ObjectInfo (
      { required this.img }
      ) : super();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text('${img.name}'),
            Align(
                alignment: Alignment.topLeft,
                child: Text("Photos",style: TextStyle(fontWeight: FontWeight.bold),)),
            SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8),
                  itemCount: img.images!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage("${img.images![index].url}"),
                              fit: BoxFit.cover
                          )
                      ),
                    );
                  }
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text("Informations sur l'objet",style: TextStyle(fontWeight: FontWeight.bold),)),
            Text("${img.info}"),
            Align(
              alignment: Alignment.topLeft,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xff6c5ce7)),
                    onPressed: () => {},
                    child: Text("Modifier l'objet")
                )
            )
          ],
        )
    );
  }}