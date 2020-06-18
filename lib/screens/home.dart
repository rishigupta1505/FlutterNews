

import 'package:flutter/material.dart';
import 'package:news_app/models/ArticleModel.dart';
import 'package:news_app/models/CategoryModel.dart';
import 'package:news_app/models/News.dart';
import 'package:news_app/models/getCategories.dart';
import 'package:news_app/screens/article_view.dart';
import 'package:news_app/screens/category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories=new List<CategoryModel>();
  List<ArticleModel> articles=new List<ArticleModel>();
  bool _loading=true;
  void initState()
  {
    super.initState();
    categories=getCategories();
    getNews();
  }

  getNews() async
  {
    News newsi=News();
    await newsi.getNews();
    articles=newsi.news;
    setState(() {
      _loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Center(
        child: RichText(text: TextSpan(children: [
          TextSpan(text: 'Flutter ',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold))
          ,TextSpan(text: 'News',style: TextStyle(fontSize: 30,color: Colors.blue,fontWeight: FontWeight.bold))

        ])),
      ),elevation: 0,),
      body: _loading?Center(child: Container(child: CircularProgressIndicator())):SingleChildScrollView(
              child: Container(
              child:Column(children: [
        Container(height:120,child: ListView.builder(scrollDirection: Axis.horizontal,shrinkWrap: true,itemBuilder: (BuildContext context, int index) { 
            return CategoryTile(imageUrl: categories[index].imageUrl,categoryName: categories[index].categoryName,);
           },itemCount: categories.length,),)
              ,
              Container(child: ListView.builder(physics: ClampingScrollPhysics(),shrinkWrap: true,itemBuilder: (BuildContext context, int index) { 
          return NewsTile(desc: articles[index].content,imageUrl: articles[index].imageUrl,title: articles[index].title,url: articles[index].url,);
               },itemCount: articles.length,),)
              ],
              
              
              )
            ),
      )
      );
    
  }
}
class CategoryTile extends StatelessWidget {
  final String imageUrl,categoryName;

  const CategoryTile({Key key, this.imageUrl, this.categoryName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child:Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),child: Image.network(imageUrl,width: 120,height:60,fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.black26,borderRadius:BorderRadius.all(Radius.circular(20))),
              
              child:Text(categoryName,style:TextStyle(fontWeight: FontWeight.bold,color:Colors.white)),width:120,height:60)
          ],)
        ),
      ),
      onTap: ()=>{
         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>CategoryNews(category: categoryName,) 

         ))
      },
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imageUrl,title,desc,url;

  const NewsTile({Key key, this.imageUrl, this.title, this.desc, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>{
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>ArticleView(blogurl: url,) 

         ))
      }
      ,
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Card(
                      child: Column(children:[
                  Image.network(imageUrl),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(title,style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(desc),
                  )
                ]),
            ),
          ),
        ),
      ),
    );
  }
}