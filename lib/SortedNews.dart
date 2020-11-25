import 'package:flutter/material.dart';
import 'News.dart';
import 'BlogTile.dart';

class SortedNewsClass extends StatefulWidget {
  final search;
  final sort;
  SortedNewsClass({this.sort, this.search});
  @override
  _SortedNewsClassState createState() => _SortedNewsClassState();
}

class _SortedNewsClassState extends State<SortedNewsClass> {
  String sorted = '';
  bool loadingProcess = true;
  var newsList;
  void getNews() async {
    SortedNews news = SortedNews();
    await news.getNews(widget.search, widget.sort);
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
                    sorted = value;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SortedNewsClass(
                                  search: widget.search,
                                  sort: sorted,
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
