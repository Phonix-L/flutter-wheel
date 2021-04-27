import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wheel/data/demo_card_data.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

/// 图片预览查看器demo
class PhotoViewDemo extends StatefulWidget {
  @override
  _PhotoViewDemoState createState() => _PhotoViewDemoState();
}

class _PhotoViewDemoState extends State<PhotoViewDemo>
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
        child: ListView(
          padding: const EdgeInsets.only(top: 20, bottom: 40),
          children: [
            desc(),
            ListTile(title: Text("默认效果")),
            GestureDetector(
              child: Container(
                height: 300,
                color: Colors.grey,
                child: Hero(
                  tag: "simple",
                  child: Image.asset(imgs[0], fit: BoxFit.cover),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(new FadeRoute(
                    page: PhotoViewSimpleScreen(
                  imageProvider: AssetImage(imgs[0]),
                  heroTag: 'simple',
                )));
              },
            ),
            ListTile(title: Text("多图预览")),
            Container(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: imgs.length,
                itemBuilder: (context, index) {
                  return renderImage(index);
                },
                separatorBuilder: (context, index) {
                  return Container(width: 5);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // 描述
  Widget desc() {
    DemoCardData data = DemoCardData.values()['photo_view'];
        return Column(
      children: [
        Row(
          children: [Text('轮子名称 ：'), Text('photo_view')],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('轮子概述 ：'), Expanded(child: Text('${data.desc}'))],
        ),
        Row(children: [
          Text('推荐指数 ：'),
          RatingBarIndicator(
            rating: data.recommendRating,
            itemBuilder: (context, index) =>
                Icon(Icons.star, color: Colors.amber),
            unratedColor: Colors.white,
            itemCount: 5,
            itemSize: 15,
          ),
        ]),
        Row(
          children: [
            Text('常用指数 ：'),
            RatingBarIndicator(
              rating: data.useRating,
              itemBuilder: (context, index) =>
                  Icon(Icons.star, color: Colors.amber),
              unratedColor: Colors.white,
              itemCount: 5,
              itemSize: 15,
            ),
          ],
        ),
      ],
    );
  }

  Widget renderImage(int index) {
    var img = imgs[index];
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(new FadeRoute(
            page: PhotoViewGalleryScreen(
          images: imgs,
          index: index,
          heroTag: img,
        )));
      },
      child: Container(
        height: 100,
        width: 100,
        child: Hero(
          tag: img,
          child: Image.asset(img, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

/// 单图预览
class PhotoViewSimpleScreen extends StatelessWidget {
  const PhotoViewSimpleScreen({
    this.imageProvider, //图片
    this.loadingChild, //加载时的widget
    this.backgroundDecoration, //背景修饰
    this.minScale, //最大缩放倍数
    this.maxScale, //最小缩放倍数
    this.heroTag, //hero动画tagid
  });
  final ImageProvider imageProvider;
  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: PhotoView(
                imageProvider: imageProvider,
                loadingBuilder: (context, event) {
                  return loadingChild;
                },
                backgroundDecoration: backgroundDecoration,
                minScale: minScale,
                maxScale: maxScale,
                heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
                enableRotation: true,
              ),
            ),
            Positioned(
              //右上角关闭按钮
              right: 10,
              top: MediaQuery.of(context).padding.top,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// 多图预览
class PhotoViewGalleryScreen extends StatefulWidget {
  List images = [];
  int index = 0;
  String heroTag;
  PageController controller;

  PhotoViewGalleryScreen(
      {Key key,
      @required this.images,
      this.index,
      this.controller,
      this.heroTag})
      : super(key: key) {
    controller = PageController(initialPage: index);
  }

  @override
  _PhotoViewGalleryScreenState createState() => _PhotoViewGalleryScreenState();
}

class _PhotoViewGalleryScreenState extends State<PhotoViewGalleryScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
                child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: AssetImage(widget.images[index]),
                  heroAttributes: widget.heroTag.isNotEmpty
                      ? PhotoViewHeroAttributes(tag: widget.heroTag)
                      : null,
                );
              },
              itemCount: widget.images.length,
              // loadingChild: Container(),
              backgroundDecoration: null,
              pageController: widget.controller,
              enableRotation: true,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            )),
          ),
          Positioned(
            //图片index显示
            top: MediaQuery.of(context).padding.top + 15,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("${currentIndex + 1}/${widget.images.length}",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
          Positioned(
            //右上角关闭按钮
            right: 10,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
