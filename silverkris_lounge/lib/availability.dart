import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class AvailabilityScreen extends StatefulWidget {
  AvailabilityScreen(
      {Key key,
      this.privRoom,
      this.dinerRoom1,
      this.dinerRoom2,
      this.dinerRoom3,
      this.restArea1,
      this.restArea2,
      this.restArea3,
      this.studyArea1,
      this.studyArea2})
      : super(key: key);

  final String privRoom;
  final String dinerRoom1;
  final String dinerRoom2;
  final String dinerRoom3;
  final String restArea1;
  final String restArea2;
  final String restArea3;
  final String studyArea1;
  final String studyArea2;

  @override
  _AvailabilityScreenState createState() => new _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SilverKris Lounge Availability',
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop()),
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
                child: displayBox(widget.privRoom)),
            Container(
                alignment: Alignment(-0.4, 0.3),
                child: displayBox(widget.dinerRoom1)),
            Container(
                alignment: Alignment(0.1, -0.3),
                child: displayBox(widget.dinerRoom2)),
            Container(
                alignment: Alignment(0.12, 0.25),
                child: displayBox(widget.dinerRoom3)),
            Container(
                alignment: Alignment(-0.8, 0.58),
                child: displayBox(widget.studyArea1)),
            Container(
                alignment: Alignment(0.75, -0.33),
                child: displayBox(widget.studyArea2)),
            Container(
                alignment: Alignment(-0.45, 0.8),
                child: displayBox(widget.restArea1)),
            Container(
                alignment: Alignment(0.2, 0.8),
                child: displayBox(widget.restArea2)),
            Container(
                alignment: Alignment(0.05, -0.8),
                child: displayBox(widget.restArea3)),
          ],
        )));
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
