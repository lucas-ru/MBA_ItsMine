import 'package:flutter/material.dart';
import 'package:mba_its_mine/NfcManager/nfc_writer.dart';

import 'NfcManager/nfc_reader.dart';
import 'object_profile.dart';
import 'package:http/http.dart' as http;


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Future<http.Response> fetchAlbum() {
    return http.get(Uri.parse('http://localhost:1337/images'));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xff6c5ce7),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NfcWriter()),
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
                      onPressed: () => {
                      fetchAlbum()
                      },
                      child: Text("Scanner un objet",style: TextStyle(color: Color(0xff6c5ce7)),))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.topLeft,
                  child: Text("Mes objets")),
            ),
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ObjectProfile()),
                      )
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("https://via.placeholder.com/150"),
                                    fit: BoxFit.cover
                              )
                            ),
                          ),
                          Text('Objet 1')
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ObjectProfile()),
                      )
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("https://via.placeholder.com/150"),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          Text('Objet 2')
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ObjectProfile()),
                      )
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("https://via.placeholder.com/150"),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          Text('Objet 3')
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ObjectProfile()),
                      )
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("https://via.placeholder.com/150"),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          Text('Objet 4')
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ObjectProfile()),
                      )
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("https://via.placeholder.com/150"),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          Text('Objet 5')
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}