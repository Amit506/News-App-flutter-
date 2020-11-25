import 'package:dartnews/SortedNews.dart';
import 'package:flutter/material.dart';
import 'News.dart';
import 'BlogTile.dart';

class SearchedNewsClass extends StatefulWidget {
  final search;
  SearchedNewsClass({this.search});
  @override
  _SearchedNewsClassState createState() => _SearchedNewsClassState();
}

class _SearchedNewsClassState extends State<SearchedNewsClass> {
  String sort = '';
  bool loadingProcess = true;
  var newsList;
  void getNews() async {
    SearchedNews news = SearchedNews();
    await news.getNews(widget.search);
    newsList = news.news;
    setState(() {
      loadingProcess = false;
      newsList = news.news;
    });
  }

  @override
  void initState() {
    loadingProcess = true;
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.home,
              color: Colors.black54,
            )),
        elevation: 1.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Am',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Dart',
              style: TextStyle(color: Colors.black54),
            ),
            Text(
              'News',
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        actions: <Widget>[
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                isDense: true,
                hint: Text('sort by'),
                items: [
                  DropdownMenuItem(
                    child: Text('relevancy'),
                    value: 'relevancy',
                  ),
                  DropdownMenuItem(
                    child: Text('popularity'),
                    value: 'popularity',
                  ),
                  DropdownMenuItem(
                    child: Text('publishedAt'),
                    value: 'publishedAt',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    sort = value;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SortedNewsClass(
                                  search: widget.search,
                                  sort: sort,
                                )));
                  });
                }),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: loadingProcess
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 4),
                      child: Column(
                        children: [
                          Container(
                            child: ListView.builder(
                                itemCount: newsList.length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return BlogTile(
                                    title: newsList[index].title,
                                    description: newsList[index].description,
                                    url: newsList[index].urlToImage,
                                    articleUrl: newsList[index].url,
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }
}
