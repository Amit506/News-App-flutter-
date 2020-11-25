import 'package:flutter/material.dart';
import 'BlogTile.dart';
import 'News.dart';

class CategoryNewsClass extends StatefulWidget {
  final category;
  CategoryNewsClass({this.category});

  @override
  _CategoryNewsClassState createState() => _CategoryNewsClassState();
}

class _CategoryNewsClassState extends State<CategoryNewsClass> {
  bool loadingProcess = true;
  var newsList;
  void getNews() async {
    CategoryNews news = CategoryNews();
    await news.getNews(widget.category);
    newsList = news.news;
    setState(() {
      loadingProcess = false;
      newsList = news.news;
    });
    print(newsList[0].urlToImage);
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
        elevation: 1.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dart',
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(
              width: 4.0,
            ),
            Text(
              widget.category,
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ],
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.home,
              color: Colors.black54,
            )),
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: loadingProcess
                ? Center(child:CircularProgressIndicator(),)
                : SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.only(top:4),
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
