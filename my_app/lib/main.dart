import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

enum Status { empty, low, medium, high }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(title: 'Flutter Demo Home Page'));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final _apiGatewayURL = 'https://example.com/whatsit/create';
  final dbRef = FirebaseDatabase.instance.reference();
  var subscription;

  Status privRoom;
  Status restArea1;
  Status restArea2;
  Status restArea3;
  Status studyArea1;
  Status studyArea2;
  Status studyArea3;
  Status dinerRoom1;
  Status dinerRoom2;
  Status dinerRoom3;

  void listenData() {
    subscription = dbRef.onChildChanged.listen((event) {
      setState(() {
        log(event.snapshot.key.toString());
        log(event.snapshot.value.toString());
      });
    });
  }

  // void _initStatus() {
  //   http
  //       .get(this._apiGatewayURL)
  //       .then((response) => response.body)
  //       .then(json.decode)
  //       .then((status) => status.forEach((post) {
  //             setState(() {
  //               privRoom = checkStatus(post['privRoom']);
  //               restArea1 = checkStatus(post['restArea1']);
  //               restArea2 = checkStatus(post['restArea2']);
  //               restArea3 = checkStatus(post['restArea3']);
  //               studyArea1 = checkStatus(post['studyArea1']);
  //               studyArea2 = checkStatus(post['studyArea2']);
  //               studyArea3 = checkStatus(post['studyArea3']);
  //             });
  //           }));
  // }

  // Status checkStatus(int numPpl) {
  //   if (numPpl >= 10)
  //     return Status.high;
  //   else if (10 > numPpl && 5 >= numPpl)
  //     return Status.high;
  //   else if (numPpl < 5)
  //     return Status.low;
  //   else
  //     return Status.empty;
  // }

  @override
  void initState() {
    listenData();
    //_initStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/background.png')))),
        Container(alignment: Alignment(-0.6, -0.3), child: Text('Private Room')),
        Container(alignment: Alignment(-0.6, -0.5), child: MyLayoutWidget(string: "privRoom",)),
        Container(alignment: Alignment(-0.6, -0.2), child: Text('$privRoom')),

        Container(alignment: Alignment(-0.45, 0.15), child: Text('Diner Room 1')),
        Container(alignment: Alignment(-0.45, 0.25), child: Text('$dinerRoom1')),
        Container(alignment: Alignment(-0.45, -0), child: MyLayoutWidget(string: "dinerRoom1",)),

        Container(alignment: Alignment(0.2, 0.2), child: Text('Diner Room 2')),
        Container(alignment: Alignment(0.2, 0.3), child: Text('$dinerRoom2')),
        Container(alignment: Alignment(0.2, 0.05), child: MyLayoutWidget(string: "dinerRoom2",)),

        Container(alignment: Alignment(0.1, -0.3), child: Text('Diner Room 3')),
        Container(alignment: Alignment(0.1, -0.2), child: Text('$dinerRoom3')),
        Container(alignment: Alignment(0.1, -0.5), child: MyLayoutWidget(string: "dinerRoom3",)),
  
        Container(alignment: Alignment(-0.85, 0.45), child: Text('Study Area 1')),
        Container(alignment: Alignment(-0.85, 0.3), child: MyLayoutWidget(string: "studyArea1",)),
        Container(alignment: Alignment(-0.85, 0.55), child: Text('$studyArea1')),

        Container(alignment: Alignment(0.8, -0.2), child: MyLayoutWidget(string: "studyArea2",)),
        Container(alignment: Alignment(0.8, -0.45), child: Text('Study Area 2')),
        Container(alignment: Alignment(0.8, -0.35), child: Text('$studyArea2')),

        Container(alignment: Alignment(-0.45, 0.7), child: MyLayoutWidget(string: "restArea1",)),
        Container(alignment: Alignment(-0.45, 0.8), child: Text('Rest Area 1')),
        Container(alignment: Alignment(-0.45, 0.9), child: Text('$restArea1')),

        Container(alignment: Alignment(0.2, 0.7), child: MyLayoutWidget(string: "restArea2",)),
        Container(alignment: Alignment(0.2, 0.8), child: Text('Rest Area 2')),
        Container(alignment: Alignment(0.2, 0.9), child: Text('$restArea2')),

        Container(alignment: Alignment(-0.15, -0.9), child: MyLayoutWidget(string: "restArea3",)),
        Container(alignment: Alignment(0.1, -0.85), child: Text('Rest Area 3')),
        Container(alignment: Alignment(0.1, -0.75), child: Text('$restArea3')),
      ],
    )));
  }

}

class MyLayoutWidget extends StatelessWidget {
  MyLayoutWidget({Key key, this.string}) : super(key: key);
  final String string; 

  final dbRef = FirebaseDatabase.instance.reference();

  void writeData(String child) {
    dbRef.child(child).update({
      "cleaned": true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("$_cleanchanged"),
      onPressed: () {
          showAlertDialog(context);
        },
      );
  }

  showAlertDialog(BuildContext context) { 
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Color(0xFF222831),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              content: RaisedButton(
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white70,
                  child: Text('CLEANED'),
                  onPressed: () {
                    writeData(string);
                    Navigator.of(context).pop();
                  }),
              actions: <Widget>[
                FlatButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }
}