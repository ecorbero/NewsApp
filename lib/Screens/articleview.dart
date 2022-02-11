import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;
  ArticleView({this.blogUrl});
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer=Completer();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){
          Navigator.pop(context);
        },),
        backgroundColor: Colors.white,
        title: Row(
               mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Text("Flutter",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold,fontSize: 25)),
                    Text("News",style: TextStyle(color: Colors.blue,fontWeight:FontWeight.bold,fontSize: 25))
                  ]
                
              ),
              actions: [
                Opacity(opacity: 0,child: 
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.save),
                ),)
              ],
              centerTitle: true,
              elevation: 0.0,
        ),
        
      
      body:Container(

          child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: ((WebViewController webViewController){
          _completer.complete(webViewController);
          }),
        ),

      
      ),
    );
  
  }
}