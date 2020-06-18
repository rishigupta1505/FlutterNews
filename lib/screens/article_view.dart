import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ArticleView extends StatefulWidget {
  final String blogurl;

  const ArticleView({Key key, this.blogurl}) : super(key: key);
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  
  final Completer<WebViewController> _completer=Completer<WebViewController>(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Center(
        child: RichText(text: TextSpan(children: [
          TextSpan(text: 'Flutter ',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold))
          ,TextSpan(text: 'News',style: TextStyle(fontSize: 30,color: Colors.blue,fontWeight: FontWeight.bold))

        ])),
      ),elevation: 0,)
      ,
        body: Container(
          height:MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
        child: WebView(initialUrl: widget.blogurl,onWebViewCreated: ((WebViewController webviewcontroller){
          _completer.complete(webviewcontroller);
        }),),
      ),
    );
  }
}