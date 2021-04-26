import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_wheel/data/demo_card_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Wheel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        children: DemoCardData.demoList
            .map((demo) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  child: DemoCard(demoCardData: demo),
                ))
            .toList(),
      ),
    );
  }
}

class DemoCard extends StatelessWidget {
  final DemoCardData demoCardData;

  const DemoCard({Key key, @required this.demoCardData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => demoCardData.routePage,
            fullscreenDialog: true,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 15),
              color: Colors.black.withOpacity(0.15),
              blurRadius: 30,
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              demoCardData.title,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              demoCardData.desc,
              style: TextStyle(color: Color(0xff666666), fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
