import 'package:flutter/material.dart';


class AddPassword extends StatefulWidget {
  const AddPassword({Key? key}) : super(key: key);

  @override
  State<AddPassword> createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // 1
          title: const Text(
            "Sécuriser l'objet",
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
                  Expanded(
                    flex: 1,
                    child: Align(
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.looks_4,
                                color: Color(0xff6c5ce7),
                                size: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text("Ajouter un mot de passe", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 20, top: 8),
                            child: Text("Le mot de passe sera demandé pour modifier l'objet et donc pouvoir se l'attribuer. Il permet de prouver que c'est votre objet"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Align(child: Text("Mot de passe"), alignment: Alignment.topLeft,),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Etape 3/3', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      MaterialButton(
                          color: Color(0xff6c5ce7),
                          textColor: Colors.white,
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text('Sauvegarder'),
                              ),
                              Icon(Icons.rss_feed, size: 15,)
                            ],

                          ),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0))
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => AddPictures()),
                            // );
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