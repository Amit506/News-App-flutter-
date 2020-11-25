import 'package:flutter/material.dart';
import 'WebView.dart';

class BlogTile extends StatelessWidget {
  final title;
  final url;
  final description;
  final articleUrl;
  final time;
  BlogTile(
      {this.description, this.title, this.url, this.articleUrl, this.time});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      urll: articleUrl,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(url != null
                    ? url
                    : 'https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80')),
            SizedBox(
              height: 5,
            ),
            Text(title != null ? title : 'server not responding',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                )),
            SizedBox(
              height: 8.0,
            ),
            Text(
              description != null ? description : 'server not responding',
              style: TextStyle(color: Colors.black54),
            ),
            Container(
              padding: EdgeInsets.only(top:3),
              width: double.infinity,
              child: Text(
                time.toString()!='null'?time.toString():' ',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
