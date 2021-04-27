import 'package:flutter/material.dart';
import 'package:flutter_wheel/demo/flutter_swiper_demo.dart';
import 'package:flutter_wheel/demo/photo_view_demo.dart';

class DemoCardData {
  DemoCardData(
      {this.title,
      this.desc,
      this.recommendRating,
      this.useRating,
      this.routePage});

  String title;
  String desc;

  /// 推荐指数
  double recommendRating;

  /// 常用指数
  double useRating;

  Widget routePage;

  static Map<String, DemoCardData> values() {
    Map<String, DemoCardData> demoMap = {
      'flutter_swiper': DemoCardData(
        title: 'Flutter swiper',
        desc: 'flutter最强大的siwiper, 多种布局方式，无限轮播，Android和IOS双端适配',
        recommendRating: 5.0,
        useRating: 5.0,
        routePage: FlutterSwiperDemo(),
      ),
      'photo_view': DemoCardData(
        title: 'Flutter swiper',
        desc: 'flutter最强大的siwiper, 多种布局方式，无限轮播，Android和IOS双端适配',
        recommendRating: 5.0,
        useRating: 5.0,
        routePage: FlutterSwiperDemo(),
      ),
    };
    return demoMap;
  }
}
