import 'package:flutter/material.dart';
import '../data/news.dart';

class NewsDetails extends StatefulWidget {
  final Article article;

  NewsDetails(this.article);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.network((widget.article.urlToImage==null
                      ?"https://www.healthcareitnews.com/sites/hitn/files/Global%20healthcare_2.jpg"
                      :widget.article.urlToImage)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.article.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.article.description,
                      style: TextStyle(fontSize: 17.0),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}