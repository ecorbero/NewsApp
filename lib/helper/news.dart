import '../models/article_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class News {
  List<ArticleModel> newsList = [];

  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=YOUR_NEWSAPI_KEY";

    Response res = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(res.body);

    if (jsonData['status'] == "ok") {
      List articleList = jsonData["articles"];

      for (int i = 0; i < articleList.length; i++) {
        Map eacharticle = articleList[i];

        if (eacharticle["urlToImage"] != null &&
            eacharticle["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: eacharticle['title'],
              author: eacharticle['author'],
              content: eacharticle['content'],
              description: eacharticle['description'],
              url: eacharticle['url'],
              urlToImage: eacharticle['urlToImage']);

          newsList.add(articleModel);
        }
      }
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> newsList = [];

  Future<void> getNews(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=YOUR_NEWSAPI_KEY";

    Response res = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(res.body);

    if (jsonData['status'] == "ok") {
      List articleList = jsonData["articles"];

      for (int i = 0; i < articleList.length; i++) {
        Map eacharticle = articleList[i];

        if (eacharticle["urlToImage"] != null &&
            eacharticle["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: eacharticle['title'],
              author: eacharticle['author'],
              content: eacharticle['content'],
              description: eacharticle['description'],
              url: eacharticle['url'],
              urlToImage: eacharticle['urlToImage']);

          newsList.add(articleModel);
        }
      }
    }
  }
}
