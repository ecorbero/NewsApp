import 'package:eNews/helper/news.dart';
import 'package:eNews/models/article_model.dart';
import 'package:eNews/screens/articleview.dart';
import 'package:eNews/screens/categorynews.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<String> newsCategoryList=["Business","Entertainment","General","Health","Science","Crypto"];

  List<ArticleModel> articles = [];

  bool loading = true;

  Map<String, Color> categoryMap = {
    "General": const Color.fromARGB(255, 0, 123, 139),
    "Business": const Color.fromARGB(255, 130, 0, 0),
    "Entertainment": const Color.fromARGB(255, 0, 76, 139),
    "Health": const Color.fromARGB(255, 122, 0, 67),
    "Science": const Color.fromARGB(255, 9, 132, 0),
    "Sports": const Color.fromARGB(255, 20, 0, 133),
    "Technology": Color.fromARGB(182, 0, 0, 0),
  };

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.newsList;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text("e",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
            Text("News",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 25))
          ]),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _newsCategories(),
              loading
                  ? Center(
                      child: Container(
                        child: const CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      child: Column(children: [
                        Container(
                          // height: Get.height*.7659,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              return BlogTile(
                                imageUrl: articles[index].urlToImage,
                                title: articles[index].title,
                                desc: articles[index].description,
                                url: articles[index].url,
                              );
                            },
                          ),
                        ),
                      ]),
                    ),
            ],
          ),
        ));
  }

  Widget _newsCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Row(
        children: [
          for (var k in categoryMap.keys)
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryNews(
                              category: k.toLowerCase(),
                            )));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: categoryMap[k]!,
                    ),
                    height: 40,
                    width: 125,
                    child: Stack(children: [
                      /*
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: categoryMap[k]!,
                          fit: BoxFit.fill,
                          height: 80,
                          width: 150,
                          color: Colors.black,
                        ),
                      ),
                        */
                      Center(
                          child: Text(
                        k,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ))
                    ])),
              ),
            ),
        ],
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String? imageUrl, title, desc, url; //
  const BlogTile(
      {required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url!,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 1,
                    color: Colors.grey,
                    offset: Offset(0.7, 0.7))
              ],
              color: Colors.white),
          width: Get.width * .8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(
                  imageUrl!,
                  height: 250,
                  width: Get.width,
                  fit: BoxFit.cover,

                  // height: 200,
                  // width: Get.width*.8,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title!,
                    style:
                        const TextStyle(color: Colors.black87, fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(desc!,
                    style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
