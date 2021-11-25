import 'package:flutter/material.dart';
import 'package:mba_its_mine/add_password.dart';


class AddPictures extends StatefulWidget {
  const AddPictures({Key? key}) : super(key: key);

  @override
  State<AddPictures> createState() => _AddPicturesState();
}

class _AddPicturesState extends State<AddPictures> {

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
                        Expanded(
                          child: GridView.count(
                            primary: false,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: <Widget>[
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
                            ],
                          ),
                        ),
                        MaterialButton(
                            color: Color(0xff6c5ce7),
                            textColor: Colors.white,
                            child: Text('Prendre en photo'),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8.0))
                            ),
                            onPressed: () {}
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Etape 1/3', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
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
                            MaterialPageRoute(builder: (context) => AddPassword()),
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