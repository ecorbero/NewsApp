import 'package:NewsApp/Models/article_model.dart';
import 'package:NewsApp/Screens/articleview.dart';
import 'package:NewsApp/Screens/categorynews.dart';
import 'package:NewsApp/helper/news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  // List<String> newsCategoryList=["Business","Entertainment","General","Health","Science","Crypto"];

  List<ArticleModel> articles= new List<ArticleModel>();

  bool loading=true;

  Map<String,String> categoryMap= {
    "Business": "https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fblogs-images.forbes.com%2Falejandrocremades%2Ffiles%2F2018%2F12%2Fbusiness-3605367_1920-1200x741.jpg",
    "Entertainment": "https://www.pwc.co.uk/entertainment-media/assets/ent-media-2020-hero.jpg",
    "General": "https://newsinterpretation.com/wp-content/uploads/2020/03/news33.jpg",
    "Health": "https://online.stanford.edu/sites/default/files/styles/figure_default/public/2020-08/artificial-intelligence-in-healthcare-MAIN.jpg?itok=CFkrao5e",
    "Science": "https://s3-ap-south-1.amazonaws.com/blogmindler/bloglive/wp-content/uploads/2018/12/12163355/Pure-Science-Courses-After-Class-12th.png",
    "Sports": "https://static01.nyt.com/images/2020/07/21/autossell/sports-reboot-promo-still/sports-reboot-promo-still-facebookJumbo.jpg",
    "Technology": "https://www.homecareinsight.co.uk/wp-content/uploads/2020/07/connected-technology.jpg",
  };


  getNews() async{

    News newsClass = News();
    await newsClass.getNews();
    articles= newsClass.newsList;
    setState(() {
      loading=false;
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
      resizeToAvoidBottomPadding: false,

      appBar: AppBar(
        
        backgroundColor: Colors.white,
        title: Row(
               mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Text("Flutter",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold,fontSize: 25)),
                    Text("News",style: TextStyle(color: Colors.blue,fontWeight:FontWeight.bold,fontSize: 25))
                  ]
                
              ),
              
              centerTitle: true,
              elevation: 0.0,
        ),
      body:
      SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
          children: [
            _newsCategories(),
            loading?Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              ):Container(
                
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
                    ),]
                  ),
                ),
          ],
        ),
      )
         
    );
  }



  Widget _newsCategories(){
    return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()
          ),
          child: Row(
        
           children: [

          for(var k in categoryMap.keys)

               GestureDetector(
                  onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryNews(
                     category: k.toLowerCase(),
                   )));
                  },
                  child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black,
                      ),
                    height: 80,
                    width:150,
                    
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                            imageUrl: categoryMap[k],
                            fit: BoxFit.fill,
                            height: 80,
                            width: 150,
                          ),
                        ),
                        Center(child: Text(k,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),
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