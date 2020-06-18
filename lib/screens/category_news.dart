import 'package:flutter/material.dart';
import 'package:news_app/models/ArticleModel.dart';
import 'package:news_app/models/News.dart';
import 'package:news_app/screens/article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  const CategoryNews({Key key, this.category}) : super(key: key);
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles=List<ArticleModel>();
  bool _loading=true;
  void initState()
  {
    super.initState();
    getCategoryNews();
  }
  getCategoryNews() async
  {
    NewsForCategory newsi=NewsForCategory();
    await newsi.getNewsForCategory(widget.category);
    articles=newsi.news;
    setState(() {
      _loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Center(
        child: RichText(text: TextSpan(children: [
          TextSpan(text: 'Flutter ',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold))
          ,TextSpan(text: 'News',style: TextStyle(fontSize: 30,color: Colors.blue,fontWeight: FontWeight.bold))

        ])),
      ),elevation: 0,)
      ,body:_loading?Center(child: Container(child: CircularProgressIndicator())): Container(child: ListView.builder(physics: ClampingScrollPhysics(),shrinkWrap: true,itemBuilder: (BuildContext context, int index) { 
          return NewsTile(desc: articles[index].content,imageUrl: articles[index].imageUrl,title: articles[index].title,url: articles[index].url,);
               },itemCount: articles.length,),)
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