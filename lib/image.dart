import 'dart:convert';
import 'dart:html';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class image{
  // load(){
  //   var request = new http.MultipartRequest("POST", url);
  //   request.fields['user'] = 'someone@somewhere.com';
  //   request.files.add(http.MultipartFile.fromPath(
  //     'package',
  //     'build/package.tar.gz',
  //     contentType: new MediaType('application', 'x-tar'),
  //   ));
  //   request.send().then((response) {
  //     if (response.statusCode == 200) print("Uploaded!");
  //   });
  // }
  late String uploadURL;

  Upload(imageFile) async {
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(uploadURL);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }
}


