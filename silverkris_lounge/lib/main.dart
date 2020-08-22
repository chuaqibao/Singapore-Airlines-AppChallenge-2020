import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:silverkris_lounge/availability.dart';
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
  final _apiGatewayURL =
      'https://mkr9pqnggb.execute-api.us-east-1.amazonaws.com/silverKris/silverKrisFunc';
  String privRoom;
  String restArea1;
  String restArea2;
  String restArea3;
  String studyArea1;
  String studyArea2;
  String studyArea3;
  String dinerRoom1;
  String dinerRoom2;
  String dinerRoom3;

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

  void writeData() {
    dbRef.child('').set({});
  }

  void readData() {
    dbRef.once().then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value);
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
      return 'HIGH';
    else if (10 > numPpl && numPpl >= 5)
      return 'MEDIUM';
    else if (numPpl < 5 && numPpl > 0)
      return 'LOW';
    else
      return 'EMPTY';
  }

  @override
  void initState() {
    readData();
    _initStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('SilverKris Lounge', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.jpg"),
                    fit: BoxFit.cover)),
            child: RaisedButton(
                child: Text('Availability'),
                onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return AvailabilityScreen(
                          privRoom: privRoom,
                          dinerRoom1: dinerRoom1,
                          dinerRoom2: dinerRoom2,
                          dinerRoom3: dinerRoom3,
                          restArea1: restArea1,
                          restArea2: restArea2,
                          restArea3: restArea3,
                          studyArea1: studyArea1,
                          studyArea2: studyArea2);
                    })))));
  }

  Widget displayBox(String text) {
    Color color;
    if (text == "HIGH")
      color = Colors.red;
    else if (text == "MEDIUM")
      color = Colors.yellow;
    else if (text == "LOW")
      color = Colors.green;
    else
      color = Colors.green;
    return Container(
        width: 75,
        height: 20,
        alignment: Alignment.center,
        child: Text(text),
        color: color);
  }
}
