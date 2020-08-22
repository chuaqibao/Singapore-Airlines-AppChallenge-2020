import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

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
  final dbRef = FirebaseDatabase.instance.reference();
  var subscription;
  var subscription1;
  var subscription2;
  var subscription3;
  var subscription4;
  var subscription5;
  var subscription6;
  var subscription7;
  var subscription8;
  var subscription9;
  final _apiGatewayURL =
      'https://mkr9pqnggb.execute-api.us-east-1.amazonaws.com/silverKris/silverKrisFunc';
  static String privRoom;
  static String restArea1;
  static String restArea2;
  static String restArea3;
  static String studyArea1;
  static String studyArea2;
  static String studyArea3;
  static String dinerRoom1;
  static String dinerRoom2;
  static String dinerRoom3;

  void prepStatus() {
    privRoom = "EMPTY";
    restArea1 = "EMPTY";
    restArea2 = "EMPTY";
    restArea3 = "EMPTY";
    studyArea1 = "EMPTY";
    studyArea2 = "EMPTY";
    studyArea3 = "EMPTY";
    dinerRoom1 = "EMPTY";
    dinerRoom2 = "EMPTY";
    dinerRoom3 = "EMPTY";
  }

  void readData() {
    dbRef.once().then((DataSnapshot dataSnapshot) {
      log("status: " + dataSnapshot.value.toString());
      var status = dataSnapshot.value;
      setState(() {
        privRoom = checkStatus(status['privRoom']['realtime']);
        restArea1 = checkStatus(status['restArea1']['realtime']);
        restArea2 = checkStatus(status['restArea2']['realtime']);
        restArea3 = checkStatus(status['restArea3']['realtime']);
        studyArea1 = checkStatus(status['studyArea1']['realtime']);
        studyArea2 = checkStatus(status['studyArea2']['realtime']);
        studyArea3 = checkStatus(status['studyArea3']['realtime']);
        dinerRoom1 = checkStatus(status['dinerRoom1']['realtime']);
        dinerRoom2 = checkStatus(status['dinerRoom2']['realtime']);
        dinerRoom3 = checkStatus(status['dinerRoom3']['realtime']);
      });
    });
  }

  void listenPrivRoom() {
    subscription1 = dbRef.child('privRoom').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      setState(() {
        privRoom = checkStatus(event.snapshot.value);
      });
    });
  }

  void listenRestArea1() {
    subscription2 = dbRef.child('restArea1').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      setState(() {
        restArea1 = checkStatus(event.snapshot.value);
      });
    });
  }

  void listenRestArea2() {
    subscription3 = dbRef.child('restArea2').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      setState(() {
        restArea2 = checkStatus(event.snapshot.value);
      });
    });
  }

  void listenRestArea3() {
    subscription4 = dbRef.child('restArea3').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      setState(() {
        restArea3 = checkStatus(event.snapshot.value);
      });
    });
  }

  void listenDinerRoom1() {
    subscription5 = dbRef.child('dinerRoom1').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      setState(() {
        dinerRoom1 = checkStatus(event.snapshot.value);
      });
    });
  }

  void listenDinerRoom2() {
    subscription6 = dbRef.child('dinerRoom2').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      setState(() {
        dinerRoom2 = checkStatus(event.snapshot.value);
      });
    });
  }

  void listenDinerRoom3() {
    subscription7 = dbRef.child('dinerRoom3').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      setState(() {
        dinerRoom3 = checkStatus(event.snapshot.value);
      });
    });
  }

  void listenStudyArea1() {
    subscription8 = dbRef.child('studyArea1').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      setState(() {
        studyArea1 = checkStatus(event.snapshot.value);
      });
    });
  }

  void listenStudyArea2() {
    subscription9 = dbRef.child('studyArea2').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      setState(() {
        studyArea2 = checkStatus(event.snapshot.value);
      });
    });
  }

  void listenStudyArea3() {
    subscription = dbRef.child('studyArea3').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      setState(() {
        studyArea3 = checkStatus(event.snapshot.value);
      });
    });
  }

  Future _initStatus() async {
    var response = await http.get(this._apiGatewayURL);
    if (response.statusCode == 200) {
      var status = jsonDecode(response.body);
      setState(() {
        privRoom = checkStatus(status['privRoom']);
        restArea1 = checkStatus(status['restArea1']);
        restArea2 = checkStatus(status['restArea2']);
        restArea3 = checkStatus(status['restArea3']);
        studyArea1 = checkStatus(status['studyArea1']);
        studyArea2 = checkStatus(status['studyArea2']);
        studyArea3 = checkStatus(status['studyArea3']);
        dinerRoom1 = checkStatus(status['dinerRoom1']);
        dinerRoom2 = checkStatus(status['dinerRoom2']);
        dinerRoom3 = checkStatus(status['dinerRoom3']);
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  String checkStatus(int numPpl) {
    if (numPpl >= 10)
      return 'HIGH\n' + 'Capacity: ' + numPpl.toString();
    else if (10 > numPpl && numPpl >= 5)
      return 'MEDIUM\n' + 'Capacity: ' + numPpl.toString();
    else if (numPpl < 5 && numPpl > 0)
      return 'LOW\n' + 'Capacity: ' + numPpl.toString();
    else
      return 'EMPTY\n' + 'Capacity: ' + numPpl.toString();
  }

  @override
  void initState() {
    readData();
    listenPrivRoom();
    listenDinerRoom1();
    listenDinerRoom2();
    listenDinerRoom3();
    listenRestArea1();
    listenRestArea2();
    listenRestArea3();
    listenStudyArea1();
    listenStudyArea2();
    listenStudyArea3();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SilverKris Lounge Availability',
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/floorplan1.png')))),
            Container(
                alignment: Alignment(-0.55, -0.2),
                child: displayBox('$privRoom')),
            Container(
                alignment: Alignment(-0.4, 0.38),
                child: displayBox('$dinerRoom1')),
            Container(
                alignment: Alignment(0.1, -0.27),
                child: displayBox('$dinerRoom2')),
            Container(
                alignment: Alignment(0.12, 0.3),
                child: displayBox('$dinerRoom3')),
            Container(
                alignment: Alignment(-0.8, 0.65),
                child: displayBox('$studyArea1')),
            Container(
                alignment: Alignment(0.73, -0.3),
                child: displayBox('$studyArea2')),
            Container(
                alignment: Alignment(-0.45, 0.9),
                child: displayBox('$restArea1')),
            Container(
                alignment: Alignment(0.2, 0.9),
                child: displayBox('$restArea2')),
            Container(
                alignment: Alignment(0.05, -0.8),
                child: displayBox('$restArea3')),
          ],
        )));
  }

  Widget displayBox(String text) {
    Color color;
    if (text.split("\n")[0] == "HIGH")
      color = Colors.red;
    else if (text.split("\n")[0] == "MEDIUM")
      color = Colors.yellow;
    else if (text.split("\n")[0] == "LOW")
      color = Colors.green;
    else
      color = Colors.green;
    return Container(
        width: 75,
        height: 30,
        alignment: Alignment.center,
        child: Text(text,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        color: color);
  }
}
