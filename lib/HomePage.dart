import 'package:dartnews/BlogTile.dart';
import 'package:dartnews/News.dart';
import 'package:flutter/material.dart';
import 'CategoryModal.dart';
import 'Category.dart';
import 'CategoryCard.dart';
import 'const.dart';
import 'SearchedNews.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loadingProcess;
  var newsList;
  List<CategorieModel> categories = List<CategorieModel>();
  void getNews() async {
    News news = News();
    await news.getNews();
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
    categories = getCategories();
    getNews();
  }

  String searchText = '';
  final textContoller = TextEditingController();
  Widget appBarTitle = appbartitle;

  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.black,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: appBarTitle,
        actions: [
          IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = Icon(
                      Icons.close,
                      color: Colors.black,
                    );
                    this.appBarTitle = new TextField(
                      controller: textContoller,
                      onChanged: (value) {
                        searchText = value; //Do something with the user input.
                      },
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchedNewsClass(
                                          search: searchText
                                              .toString()
                                              .toLowerCase(),
                                        )));
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                    );
                  } else {
                    this.actionIcon = Icon(
                      Icons.search,
                      color: Colors.black54,
                    );
                    this.appBarTitle = appbartitle;
                  }
                });
              })
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
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 6),
                            height: 70,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return CategoryCard(
                                    imageAssetUrl:
                                        categories[index].imageAssetUrl,
                                    categoryName:
                                        categories[index].categorieName,
                                  );
                                }),
                          ),
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
                                    time: newsList[index]
                                        .publishedAt
                                        .toString()
                                        .substring(0, 10),
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
