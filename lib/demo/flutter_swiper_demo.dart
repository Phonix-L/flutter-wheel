import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/// 轮播图demo 
class FlutterSwiperDemo extends StatefulWidget {
  @override
  _FlutterSwiperDemoState createState() => _FlutterSwiperDemoState();
}

class _FlutterSwiperDemoState extends State<FlutterSwiperDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  List<String> imgs = [
    'assets/images/model_1.jpg',
    'assets/images/model_2.jpg',
    'assets/images/model_3.jpg',
    'assets/images/model_4.jpg',
    'assets/images/model_5.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toStringShort()),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [Text('轮子名称 ：'), Text('flutter_swiper')],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('轮子概述 ：'),
                    Expanded(
                        child: Text(
                            'flutter最强大的siwiper, 多种布局方式，无限轮播，Android和IOS双端适配'))
                  ],
                ),
                Row(
                  children: [Text('推荐指数 ：'), Text('★★★★★')],
                ),
                Row(
                  children: [Text('常用指数 ：'), Text('★★★★★')],
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                children: [
                  normal(),
                  const SizedBox(height: 20),
                  stack(),
                  const SizedBox(height: 20),
                  tinder(),
                  const SizedBox(height: 20),
                  three(),
                  const SizedBox(height: 20),
                  custom(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 默认效果
  Widget normal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('默认效果'),
        const SizedBox(height: 20),
        Container(
          height: 250,
          child: Swiper(
            itemCount: imgs.length,
            control: SwiperControl(), // 不填则不显示左右按钮
            pagination: SwiperPagination(), // 不填不显示指示点
            autoplay: true,
            autoplayDelay: 3000,
            autoplayDisableOnInteraction: true,
            itemBuilder: (context, index) {
              return Image.asset(
                imgs[index],
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.4),
              );
            },
          ),
        ),
      ],
    );
  }

  // 堆叠效果
  Widget stack() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('堆叠效果'),
        const SizedBox(height: 20),
        Container(
          height: 300,
          child: Swiper(
            itemCount: imgs.length,
            itemWidth: 300,
            layout: SwiperLayout.STACK,
            itemBuilder: (context, index) {
              return Image.asset(
                imgs[index],
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.4),
              );
            },
          ),
        ),
      ],
    );
  }

  // 覆盖堆叠效果
  Widget tinder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('覆盖堆叠效果'),
        const SizedBox(height: 20),
        Container(
          height: 300,
          child: Swiper(
            itemCount: imgs.length,
            itemWidth: 300,
            itemHeight: 300,
            layout: SwiperLayout.TINDER,
            itemBuilder: (context, index) {
              return Image.asset(
                imgs[index],
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.4),
              );
            },
          ),
        ),
      ],
    );
  }

  // 3D滚动效果
  Widget three() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('3D滚动效果'),
        const SizedBox(height: 20),
        Container(
          height: 250,
          child: Swiper(
            itemCount: imgs.length,
            viewportFraction: 0.6,
            scale: 0.7,
            itemBuilder: (context, index) {
              return Image.asset(
                imgs[index],
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.4),
              );
            },
          ),
        ),
      ],
    );
  }

  // 自定义效果
  Widget custom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('自定义效果'),
        const SizedBox(height: 20),
        Container(
          height: 200,
          child: Swiper(
            itemCount: imgs.length,
            layout: SwiperLayout.CUSTOM,
            itemWidth: 300.0,
            itemHeight: 200.0,
            itemBuilder: (context, index) {
              return Image.asset(
                imgs[index],
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.4),
              );
            },
            customLayoutOption:
                CustomLayoutOption(startIndex: -1, stateCount: 3)
                    .addRotate([-45.0 / 180, 0.0, 45.0 / 180]).addTranslate([
              Offset(-370.0, -40.0),
              Offset(0.0, 0.0),
              Offset(370.0, 40.0)
            ]),
          ),
        ),
      ],
    );
  }
}
