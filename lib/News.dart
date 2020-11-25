import 'package:http/http.dart' as http;
import 'Article.dart';
import 'dart:convert';

class News {
  List<Article> news = [];
  String apikey = 'aa282ea6b18b44ebaa7257ccd6c94821';

  Future<void> getNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=$apikey';

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage']!= null &&element['title']!= null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            url: element['url'],
            publishedAt: DateTime.parse(element['publishedAt']),
           
          );
          news.add(article);
        }
      });
    }
  }
}

class CategoryNews{
   List<Article> news = [];
  String apikey = 'aa282ea6b18b44ebaa7257ccd6c94821';

  Future<void> getNews(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=$apikey';

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage']!= null &&element['title']!= null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            url: element['url'],
             publishedAt: DateTime.parse(element['publishedAt']),
          );
          news.add(article);
        }
      });
    }
  }
}


class SearchedNews{
 List<Article> news = [];
  String apikey = 'aa282ea6b18b44ebaa7257ccd6c94821';

  Future<void> getNews(String search) async {
    String url =
        'https://newsapi.org/v2/everything?q=$search&sortBy=popularity&apiKey=$apikey';

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage']!= null &&element['title']!= null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            url: element['url'],
            publishedAt: DateTime.parse(element['publishedAt']),
          );
          news.add(article);
        }
      });
    }
  }



}


class SortedNews{
 List<Article> news = [];
  String apikey = 'aa282ea6b18b44ebaa7257ccd6c94821';

  Future<void> getNews(String search, String sort) async {
    String url =
        'https://newsapi.org/v2/everything?q=$search&sortBy=$sort&apiKey=$apikey';

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage']!= null &&element['title']!= null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            url: element['url'],
            publishedAt: DateTime.parse(element['publishedAt']),
          );
          news.add(article);
        }
      });
    }
  }



}