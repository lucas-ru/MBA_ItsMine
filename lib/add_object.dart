import 'package:flutter/material.dart';
import 'package:mba_its_mine/add_pictures.dart';


class AddObject extends StatefulWidget {
  const AddObject({Key? key}) : super(key: key);

  @override
  State<AddObject> createState() => _AddObjectState();
}

class _AddObjectState extends State<AddObject> {

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
                      Row(
                        children: const [
                          Icon(
                              Icons.looks_one,
                              color: Color(0xff6c5ce7),
                              size: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text('Preparer un tag NFC vierge', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).highlightColor,
                          ),
                          child: Stack(
                            children: const [
                              Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.rss_feed,
                                  size: 70,
                                ),
                              ),
                              Align(
                                alignment: Alignment(1.2, 1.2),
                                child: Icon(
                                  Icons.touch_app,
                                  size: 50,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.looks_two,
                            color: Color(0xff6c5ce7),
                            size: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text('Entrez les données à stocker', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                          child: Text("Les informations sur cet écran seront visibles par toute personne scannant votre object. Faites en sorte de ne rien indiquer de trop personnel, mais suffisamment pour que la personne qui trouve l'objet puisse vous contacter en cas de perte."),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Align(child: Text("Nom de l'objet"), alignment: Alignment.topLeft,),
                            TextFormField(
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
                                  MaterialPageRoute(builder: (context) => AddPictures()),
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