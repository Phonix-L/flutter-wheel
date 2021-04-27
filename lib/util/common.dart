import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wheel/data/demo_card_data.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoWeb extends StatelessWidget {
  final String pluginName;
  const GoWeb({Key key, @required this.pluginName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DemoCardData demo = DemoCardData.values()[pluginName];

    return TextButton(
      child: Text("查看仓库", style: TextStyle(color: Colors.white)),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WebViewPage(
              title: pluginName,
              url: demo.pubUrl,
              );
        }));
      },
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const WebViewPage({Key key, this.title = '',@required this.url}) : super(key: key);  
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("${widget.title}"),
      ),
      child: SafeArea(
        child: WebView(
          initialUrl: "${widget.url}",
          //JS执行模式 是否允许JS执行
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            _controller = controller;
          },
          // onPageFinished: (url) {
          //   _controller.evaluateJavascript("document.title").then((result) {
          //     setState(() {
          //       _title = result;
          //     });
          //   });
          // },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith("myapp://")) {
              print("即将打开 ${request.url}");

              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          javascriptChannels: <JavascriptChannel>[
            JavascriptChannel(
                name: "share",
                onMessageReceived: (JavascriptMessage message) {
                  print("参数： ${message.message}");
                }),
          ].toSet(),
        ),
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
