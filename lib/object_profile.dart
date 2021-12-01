import 'package:flutter/material.dart';

import 'NfcManager/nfc_reader.dart';


class ObjectProfile extends StatefulWidget {
  const ObjectProfile({Key? key, this.uuid}) : super(key: key);
  final String? uuid;

  @override
  State<ObjectProfile> createState() => _ObjectProfileState();
}

class _ObjectProfileState extends State<ObjectProfile> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
          child: Text('Mon Object'),
        )
    );
  }
}