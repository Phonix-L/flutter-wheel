import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: MyHomePage(title: 'Flutter Wheel'),
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
  double angle = 0.0;

  List<DemoCardData> _demoList = DemoCardData.values().values.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: TweenAnimationBuilder(
                  duration: Duration(milliseconds: 500),
                  tween: Tween(end: angle),
                  builder: (BuildContext context, double value, Widget child) {
                    return Transform.rotate(
                        angle: value, child: Icon(Icons.refresh));
                  }),
              onPressed: () {
                setState(() {
                  _demoList = DemoCardData.values().values.toList();
                  angle += 2 * pi;
                });
              }),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        children: _demoList
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
            const SizedBox(height: 24),
            Text(
              demoCardData.desc,
              style: TextStyle(color: Color(0xff666666), fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text('推荐指数',
                    style: TextStyle(color: Color(0xff666666), fontSize: 14)),
                const SizedBox(width: 10),
                RatingBarIndicator(
                  rating: demoCardData.recommendRating,
                  itemBuilder: (context, index) =>
                      Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 15,
                ),
                const SizedBox(width: 20),
                Text('常用指数',
                    style: TextStyle(color: Color(0xff666666), fontSize: 14)),
                const SizedBox(width: 10),
                RatingBarIndicator(
                  rating: demoCardData.useRating,
                  itemBuilder: (context, index) =>
                      Icon(Icons.star, color: Colors.amber),
                  unratedColor: Colors.white,
                  itemCount: 5,
                  itemSize: 15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
