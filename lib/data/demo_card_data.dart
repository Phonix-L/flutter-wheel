import 'package:flutter/material.dart';
import 'package:flutter_wheel/demo/flutter_swiper_demo.dart';
import 'package:flutter_wheel/demo/photo_view_demo.dart';

class DemoCardData {
  DemoCardData({this.title, this.desc, this.routePage});

  String title;
  String desc;
  Widget routePage;

  static values() {
    List<DemoCardData> demoList = [
      DemoCardData(
          title: 'Flutter swiper',
          desc: 'flutter最强大的siwiper, 多种布局方式，无限轮播，Android和IOS双端适配',
          routePage: FlutterSwiperDemo()),
      DemoCardData(
          title: 'Photo view', desc: '可定制的图片预览查看器', routePage: PhotoViewDemo()),
       DemoCardData(
        title: 'Photo view',
        desc: '可定制的图片预览查看器',
        routePage: PhotoViewDemo()
      ),
    ];
    return demoList;
  }

  // static List<DemoCardData> demoList = [
  //   DemoCardData(
  //       title: 'Flutter swiper',
  //       desc: 'flutter最强大的siwiper, 多种布局方式，无限轮播，Android和IOS双端适配',
  //       routePage: FlutterSwiperDemo()),
  //   DemoCardData(
  //       title: 'Photo view', desc: '可定制的图片预览查看器', routePage: PhotoViewDemo()),
  //   //  DemoCardData(
  //   //   title: 'Photo view',
  //   //   desc: '可定制的图片预览查看器',
  //   //   routePage: PhotoViewDemo()
  //   // ),
  // ];
}
