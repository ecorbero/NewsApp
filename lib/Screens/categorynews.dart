import 'package:NewsApp/Models/article_model.dart';
import 'package:NewsApp/Screens/articleview.dart';
import 'package:NewsApp/helper/news.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool loading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async{

    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles= newsClass.newsList;
    setState(() {
      loading=false;
    });
  }

  
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

        body: loading?Center(
              child: Container(
                child: CircularProgressIndicator(),
              )):SingleChildScrollView(
            child: Container(
          child: Column(
            children: [
                Container(
                // height: Get.height*.7659,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: articles.length,
                  itemBuilder: (context,index){
                    return BlogTile(
                      imageUrl: articles[index].urlToImage,
                      title: articles[index].title,
                      desc: articles[index].description,
                      url:  articles[index].url,
                    );
                  },
                  
                ),
            )
            ],
          ),
        ),
              ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl,title,desc,url;
  BlogTile({@required this.imageUrl,@required this.title,@required this.desc,@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(
              blogUrl: url,
            )));
          },
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
           
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 1,
                color: Colors.grey,
                offset: Offset(
                0.7,0.7)
              )
            ],
            color: Colors.white
          ),
          width: Get.width*.8,
          
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                child: Image.network(
                
                imageUrl,
                height: 250,
                width: Get.width,
            fit: BoxFit.cover,
            
            // height: 200,
            // width: Get.width*.8,
          
              ),
            ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(title,
                    style: TextStyle(color: Colors.black87,fontSize: 18)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(desc,
                    style: TextStyle(color: Colors.grey,fontSize: 14)
                    ),
                  ),  
              ],
            ),
          ),
        
      ),
    );
  }
}