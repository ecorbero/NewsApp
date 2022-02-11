import 'dart:convert';

import 'package:NewsApp/Models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class News{

  List<ArticleModel> newsList =[];

  Future<void> getNews() async{
    String url="http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=4a33d6600ee94b988ec87578794c4d12";

     Response res= await http.get(url);

     var jsonData= jsonDecode(res.body);

     if(jsonData['status']=="ok"){

       List articleList= jsonData["articles"];

       for(int i=0;i<articleList.length;i++){

         Map eacharticle= articleList[i];

         if(eacharticle["urlToImage"]!=null && eacharticle["description"]!=null){

           ArticleModel articleModel= ArticleModel(
             title: eacharticle['title'],
             author: eacharticle['author'],
             content: eacharticle['content'],
             description: eacharticle['description'],
             url: eacharticle['url'],
             urlToImage: eacharticle['urlToImage']
           );

           newsList.add(articleModel);
         }
       }

     }

  }

}


class CategoryNewsClass{

  List<ArticleModel> newsList =[];

  Future<void> getNews(String category) async{
    String url="http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=4a33d6600ee94b988ec87578794c4d12";

     Response res= await http.get(url);

     var jsonData= jsonDecode(res.body);

     if(jsonData['status']=="ok"){

       List articleList= jsonData["articles"];

       for(int i=0;i<articleList.length;i++){

         Map eacharticle= articleList[i];

         if(eacharticle["urlToImage"]!=null && eacharticle["description"]!=null){

           ArticleModel articleModel= ArticleModel(
             title: eacharticle['title'],
             author: eacharticle['author'],
             content: eacharticle['content'],
             description: eacharticle['description'],
             url: eacharticle['url'],
             urlToImage: eacharticle['urlToImage']
           );

           newsList.add(articleModel);
         }
       }

     }

  }

}

