import 'dart:convert';
import 'package:news_app/models/ArticleModel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
class News 
{
  List<ArticleModel> news=[];
  Future<void> getNews() async
  {
    String url="http://newsapi.org/v2/top-headlines?country=in&apiKey=bf0bed7e6a77449ea765fdc516fbfae0";

    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
    if(jsondata['status']=="ok")
    { 
      jsondata['articles'].forEach((element){
        if(element['urlToImage']!=null && element['content']!=null&&element['title']!=null)
        {
           ArticleModel article = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            imageUrl: element['urlToImage'],
            content: element["content"],
            url: element["url"],
          );
          news.add(article);
        }
      });
      
    }
  }  
}
class NewsForCategory {

  List<ArticleModel> news  = [];

  Future<void> getNewsForCategory(String category) async{

    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=bf0bed7e6a77449ea765fdc516fbfae0";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['content'] != null&&element['title']!=null){
          ArticleModel article = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            imageUrl: element['urlToImage'],
         
            content: element["content"],
            url: element["url"],
          );
          news.add(article);
        }

      });
    }


  }


}
