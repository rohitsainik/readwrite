import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

void main() async {
  var data = await readData();
  if (data != null) {
    String mssg = await readData();
    print(mssg);
  }
  runApp(new MaterialApp(
    title: 'read write app',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var _textcontroller = new TextEditingController();
    return Scaffold(
        appBar: new AppBar(
          title: new Text('randw'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          child: new Column(
            children: <Widget>[
              new Padding(padding: const EdgeInsets.all(12.2)),
              new TextField(
                controller: _textcontroller,
                decoration: InputDecoration(labelText: 'enter the text here'),
              ),
              new FlatButton(
                onPressed: () => writeData(_textcontroller.toString()),
                child: new Text('send to storage'),
              ),
              new FutureBuilder(
                  future: readData(),
                  builder: (BuildContext context, AsyncSnapshot<String> data) {
                    if (data.hasData != null) {
                      return new Text(data.data.toString());
                    } else {
                      return new Text('error');
                    }
                  }),
            ],
          ),
        ),
    );
  }
}

Future<String> get _file_loc async {
  final dir = await getApplicationDocumentsDirectory();
  return dir.path;
}

Future<File> get _file_path async {
  final Path = await _file_loc;
  return new File('$Path/data.txt');
}

Future<File> writeData(String message) async {
  final file = await _file_path;
  return file.writeAsString('$message');
}

Future<String> readData() async {
  try {
    final file = await _file_path;
    String data = await file.readAsString();
    return data;
  } catch (e) {
    print('error in data');
  }
}



//import 'dart:async';
//import 'dart:io';
//
//import 'package:flutter/material.dart';
//import 'package:path_provider/path_provider.dart'; //https://pub.dartlang.org/packages/path_provider#-installing-tab-
//
//void main() async {
//  var data = await readData();
//
//  if (data != null) {
//    String message = await readData();
//    print(message);
//  }
//
//  runApp(new MaterialApp(
//    title: 'IO',
//    home: new Home(),
//  ));
//}
//
//class Home extends StatefulWidget {
//  @override
//  _HomeState createState() => new _HomeState();
//}
//
//class _HomeState extends State<Home> {
//  var _enterDataField = new TextEditingController();
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('Read/Write'),
//        centerTitle: true,
//        backgroundColor: Colors.greenAccent,
//      ),
//      body: new Container(
//        padding: const EdgeInsets.all(23.4),
//        alignment: Alignment.topCenter,
//        child: new ListTile(
//          title: new TextField(
//            controller: _enterDataField,
//            decoration: new InputDecoration(labelText: 'Write Something'),
//          ),
//          subtitle: new FlatButton(
//              color: Colors.redAccent,
//              onPressed: () {
//                //save to file
//                writeData(_enterDataField.text);
//              },
//              child: new Column(
//                children: <Widget>[
//                  new Text('Save Data'),
//                  new Padding(padding: new EdgeInsets.all(14.5)),
//                  new FutureBuilder(
//                      future: readData(),
//                      builder:
//                          (BuildContext context, AsyncSnapshot<String> data) {
//                        if (data.hasData != null) {
//                          return new Text(
//                            data.data.toString(),
//                            style: new TextStyle(color: Colors.white70),
//                          );
//                        } else {
//                          return new Text("No data saved");
//                        }
//                      }),
//                ],
//              )),
//        ),
//      ),
//    );
//  }
//}
//
//Future<String> get _localPath async {
//  final directory = await getApplicationDocumentsDirectory();
//  return directory.path; //home/directory/
//}
//
//Future<File> get _localFile async {
//  final path = await _localPath;
//
//  return new File('$path/data.txt'); //home/directory/data.txt
//}
//
////Write and Read from our file
//Future<File> writeData(String message) async {
//  final file = await _localFile;
//
//  //write to file
//  return file.writeAsString('$message');
//}
//
//Future<String> readData() async {
//  try {
//    final file = await _localFile;
//
//    //Read
//    String data = await file.readAsString();
//
//    return data;
//  } catch (e) {
//    return "Nothing saved yet!";
//  }
//}
