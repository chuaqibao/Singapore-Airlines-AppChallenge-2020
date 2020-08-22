import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  void listenPrivRoom() {
    subscription1 = dbRef.child('privRoom').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      if (event.snapshot.key == "needattention")
        setState(() {
          privRoom = printName(event.snapshot.value);
        });
    });
  }

  void listenRestArea1() {
    subscription2 = dbRef.child('restArea1').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      if (event.snapshot.key == "needattention")
        setState(() {
          restArea1 = printName(event.snapshot.value);
        });
    });
  }

  void listenRestArea2() {
    subscription3 = dbRef.child('restArea2').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      if (event.snapshot.key == "needattention")
        setState(() {
          restArea2 = printName(event.snapshot.value);
        });
    });
  }

  void listenRestArea3() {
    subscription4 = dbRef.child('restArea3').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      if (event.snapshot.key == "needattention")
        setState(() {
          restArea3 = printName(event.snapshot.value);
        });
    });
  }

  void listenDinerRoom1() {
    subscription5 = dbRef.child('dinerRoom1').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      if (event.snapshot.key == "needattention")
        setState(() {
          dinerRoom1 = printName(event.snapshot.value);
        });
    });
  }

  void listenDinerRoom2() {
    subscription6 = dbRef.child('dinerRoom2').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      if (event.snapshot.key == "needattention")
        setState(() {
          dinerRoom2 = printName(event.snapshot.value);
        });
    });
  }

  void listenDinerRoom3() {
    subscription7 = dbRef.child('dinerRoom3').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      if (event.snapshot.key == "needattention")
        setState(() {
          dinerRoom3 = printName(event.snapshot.value);
        });
    });
  }

  void listenStudyArea1() {
    subscription8 = dbRef.child('studyArea1').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      if (event.snapshot.key == "needattention")
        setState(() {
          studyArea1 = printName(event.snapshot.value);
        });
    });
  }

  void listenStudyArea2() {
    subscription9 = dbRef.child('studyArea2').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      if (event.snapshot.key == "needattention")
        setState(() {
          studyArea2 = printName(event.snapshot.value);
        });
    });
  }

  void listenStudyArea3() {
    subscription = dbRef.child('studyArea3').onChildChanged.listen((event) {
      log(event.snapshot.key.toString());
      log(event.snapshot.value.toString());
      if (event.snapshot.key == "needattention")
        setState(() {
          studyArea3 = printName(event.snapshot.value);
        });
    });
  }

  String printName(bool data) {
    String string;
    if (data == true)
      string = "Please clean!";
    else if (data == false) string = "clean";
    return string;
  }

  void readData() {
    dbRef.once().then((DataSnapshot dataSnapshot) {
      log("status: " + dataSnapshot.value.toString());
      var status = dataSnapshot.value;
      setState(() {
        privRoom = printName(status['privRoom']['needattention']);
        restArea1 = printName(status['restArea1']['needattention']);
        restArea2 = printName(status['restArea2']['needattention']);
        restArea3 = printName(status['restArea3']['needattention']);
        studyArea1 = printName(status['studyArea1']['needattention']);
        studyArea2 = printName(status['studyArea2']['needattention']);
        studyArea3 = printName(status['studyArea3']['needattention']);
        dinerRoom1 = printName(status['dinerRoom1']['needattention']);
        dinerRoom2 = printName(status['dinerRoom2']['needattention']);
        dinerRoom3 = printName(status['dinerRoom3']['needattention']);
      });
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/floorplan1.png')))),
        Container(
            alignment: Alignment(-0.6, -0.5),
            child: MyLayoutWidget(
              string: "privRoom",
              text: '$privRoom',
            )),
        Container(
            alignment: Alignment(-0.45, -0),
            child: MyLayoutWidget(
              string: "dinerRoom1",
              text: '$dinerRoom1',
            )),
        Container(
            alignment: Alignment(0.2, 0.05),
            child: MyLayoutWidget(
              string: "dinerRoom2",
              text: '$dinerRoom2',
            )),
        Container(
            alignment: Alignment(0.1, -0.5),
            child: MyLayoutWidget(
              string: "dinerRoom3",
              text: '$dinerRoom3',
            )),
        Container(
            alignment: Alignment(-0.85, 0.3),
            child: MyLayoutWidget(
              string: "studyArea1",
              text: '$studyArea1',
            )),
        Container(
            alignment: Alignment(0.8, -0.2),
            child: MyLayoutWidget(
              string: "studyArea2",
              text: '$studyArea2',
            )),
        Container(
            alignment: Alignment(-0.45, 0.7),
            child: MyLayoutWidget(
              string: "restArea1",
              text: '$restArea1',
            )),
        Container(
            alignment: Alignment(0.2, 0.7),
            child: MyLayoutWidget(
              string: "restArea2",
              text: '$restArea2',
            )),
        Container(
            alignment: Alignment(-0.15, -0.9),
            child: MyLayoutWidget(
              string: "restArea3",
              text: '$restArea3',
            )),
      ],
    )));
  }
}

class MyLayoutWidget extends StatelessWidget {
  MyLayoutWidget({Key key, this.string, this.text}) : super(key: key);
  final String string;
  final String text;

  final dbRef = FirebaseDatabase.instance.reference();

  void updateData(String child) {
    dbRef.child(child).update({"cleaned": true, "needattention": false});
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(text),
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
                    updateData(string);
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
