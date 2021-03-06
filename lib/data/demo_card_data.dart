import 'package:flutter/material.dart';
import 'package:flutter_wheel/demo/flutter_swiper_demo.dart';
import 'package:flutter_wheel/demo/photo_view_demo.dart';

class DemoCardData {
  DemoCardData(
      {this.title = '',
      this.desc = '',
      this.recommendRating = 0,
      this.useRating = 0,
      this.pubUrl = '',
      this.routePage});

  String title;
  String desc;

  /// 推荐指数
  double recommendRating;

  /// 常用指数
  double useRating;

  /// 仓库地址
  String pubUrl;

  Widget routePage;

  static Map<String, DemoCardData> values() {
    Map<String, DemoCardData> demoMap = {
      'flutter_swiper': DemoCardData(
        title: 'Flutter swiper',
        desc: 'flutter最强大的siwiper, 多种布局方式，无限轮播，Android和IOS双端适配',
        recommendRating: 5.0,
        useRating: 5.0,
        pubUrl: 'https://pub.flutter-io.cn/packages/flutter_swiper',
        routePage: FlutterSwiperDemo(),
      ),
      'photo_view': DemoCardData(
        title: 'Photo_view',
        desc: '可定制的图片预览查看器',
        recommendRating: 5.0,
        useRating: 4.0,
        pubUrl: 'https://pub.flutter-io.cn/packages/photo_view',
        routePage: PhotoViewDemo(),
      ),
    };
    return demoMap;
  }
}
