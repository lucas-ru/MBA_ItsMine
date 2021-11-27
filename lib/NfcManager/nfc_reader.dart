
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:mba_its_mine/object_profile.dart';



class NfcReader extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NfcReaderState();
}

class NfcReaderState extends State<NfcReader> {
  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  void initState() {
    _tagRead();
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
          title: Text("Scanner un objet",style: TextStyle(color: Colors.black),),
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
                      child: Text("Approchez le tag NFC de votre objet pour lire les données sauvegardées",style: TextStyle(fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                    ))
              ],
            ),
          ),
        ),
      );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var data = utf8.decode(tag.data["ndef"]["cachedMessage"]["records"][0]["payload"]).substring(1);
      result.value = tag.data;
      NfcManager.instance.stopSession();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ObjectProfile(uuid: data)),
      );
    });
  }




}