import 'dart:convert';
import 'dart:ffi';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:google_fonts/google_fonts.dart';
import 'package:vaccinator_two/pages/calendar_view.dart';
import 'package:vaccinator_two/data/child.dart' ;
import 'package:vaccinator_two/data/allChildren.dart' ;
import 'package:vaccinator_two/data/news.dart' ;
import 'package:vaccinator_two/data/news_details.dart' ;

Future<List<Article>> getData() async {
  List<Article> list;
  String link = "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=e2a0d8cdd3e54b8d86c271f4361b4aee";
  var res = await http.get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
  print(res.body);
  if (res.statusCode == 200) {
    var data = json.decode(res.body);
    var rest = data["articles"] as List;
    print(rest);
    list = rest.map<Article>((json) => Article.fromJson(json)).toList();
  }
  print("List Size: ${list.length}");
  return list;
}

Widget pageViewWidget(List<Article> article) {
  return Container(
    child: PageView.builder(
        itemCount: 20,
        controller: PageController(viewportFraction: 0.75),
        itemBuilder: (context, i) {
          return Card(
              color: Colors.teal[100],
              child: Padding(
                padding: const EdgeInsets.all(7.2),
                child: ListTile(
                title: Text(
                  '${article[i].title}',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SizedBox(
                    child: article[i].urlToImage == null
                        // ? Image(
                        //   image: AssetImage('images/no_image_available.png'),
                        //   height: 100.0,
                        //   width: 100.0,
                        // )
                        ? Image.network('https://www.google.co.in/url?sa=i&url=https%3A%2F%2Fwww.everydayhealth.com%2F&psig=AOvVaw15hAQAIXeHKnC9JwzvKSlZ&ust=1623095308729000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJiZ9q3jg_ECFQAAAAAdAAAAABAD')
                        : Image.network('${article[i].urlToImage}'),
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
                onTap: () => _onTapItem(context, article[i]),
              ),
            ),
          );
        },
    )
  );
}

void _onTapItem(BuildContext context, Article article) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => NewsDetails(article)));
}

List<Child> children;

class MyHomePage extends StatefulWidget {

   MyHomePage(
      {Key key})
      : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  {

  int _index = 0;
  int numCards = 1;
  Map data = {};
  Map arg = {} ;

  _addChild(Child newChild) async {
    children.add(newChild);
  }

  @override
  void initState() {
    super.initState();
    print(children==null);
    if(children == null ) {
      children = [];
    }
    Future.delayed(Duration.zero, () {
      setState(() {
        arg = ModalRoute.of(context).settings.arguments;
      });
      if(arg!=null)
      _addChild(arg['addedChild']);
      numCards = children.length==0?1:children.length;
      if(children != null) {
        for (Child child in children)
          child.getNextDueVaccines();
      }
    });
  }

  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            // 6 : 4 : 4 : 1
            Expanded(
                flex: 6,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 80.0),
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [
                                0.1,
                                0.4,
                                0.8,
                                0.9
                              ],
                              //colors: [Colors.lightGreen[100], Colors.lightGreen[200],Colors.green[300],Colors.teal[300]]),
                              colors: [
                                Colors.teal[50],
                                Colors.teal[100],
                                Colors.teal[300],
                                Colors.teal[400]
                              ]),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    Stack(
                      children: <Widget>[
                        Positioned(
                          top: 100,
                          left: 25,
                          child: Text('Vaccine Reminder',
                              style: //GoogleFonts.lato(textStyle:
                                TextStyle(
                                  color: Colors.cyan[900],
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                      //  ),
                        Container(
                          margin: EdgeInsets.only(top: 200.0),
                          child: SizedBox(
                            height: 150, // card height
                            child: PageView.builder(
                              itemCount: numCards ,
                              controller: PageController(viewportFraction: 0.7),
                              onPageChanged: (int index) =>
                                  setState(() => _index = index),
                              itemBuilder: (_, i) {
                                return Transform.scale(
                                  scale: i == _index ? 1 : 0.9,
                                  child: Card(
                                      elevation: 6,
                                      color:Colors.teal[600],
                                      // color: Color.fromRGBO(
                                      //     226,90,21,.5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20)),
                                      child: (children!=null && children.length !=0 && i == _index ) ? Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisSize:MainAxisSize.min,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    children[_index].name,
                                                     style:// GoogleFonts.lato(textStyle:
                                                    TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.w900,
                                               //     ),
                                        )),
                                                ),
                                              ],
                                            ),
                                            Text(
                                                "To be Taken on - ${children[_index].nextDue.keys.first
                                                    .day} - ${children[_index].nextDue
                                                    .keys.first.month} - ${children[_index].nextDue.keys.first
                                                    .year}",
                                                style: //GoogleFonts.lato(textStyle:
                                                  TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w700,
                                                //  ),
                                                )),
                                              Row(

                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 35,
                                                    backgroundColor: Color.fromRGBO(
                                                        226,114,91,0.5),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(30),
                                                      child: Image.file(
                                                        children[_index].photo,
                                                        width: 65,
                                                        height: 65,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      for(var next in children[_index].nextDue.values.first)
                                                      Text(
                                                        next,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.teal[50],
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                          ]
                                      ) :
                                      Center(
                                        child: Text("No child Added"),
                                      )
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                  overflow: Overflow.clip,
                )),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Ink(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.cyan, width: 3.0),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pushNamed(context, '/addChild');
                                  });
                                },
                              )),
                          Text('Add Child')
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Ink(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.cyan, width: 3.0),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.list_alt),
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AllChildren(children: children),
                                      ),
                                    );
                                  });
                                },
                              )),
                          Text('View All'//, style: GoogleFonts.lato()
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Ink(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.cyan, width: 3.0),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.calendar_today_rounded),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CalendarPage(
                                            child: arg['addedChild'],
                                          ),),);
                                },
                              )),
                          Text('Calender View')
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Ink(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.cyan, width: 3.0),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.add),
                                tooltip: "Add Child",
                                onPressed: () {
                                  setState(() {});
                                },
                              )),
                          Text('Immunization'),
                          Text('Articles')
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Ink(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.cyan, width: 3.0),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.list_alt),
                                tooltip: ' ',
                                onPressed: () {
                                  setState(() {});
                                },
                              )),
                          Text('Ask a Doctor'//, style: GoogleFonts.lato()
                             )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Ink(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.cyan, width: 3.0),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.calendar_today_rounded),
                                tooltip: '',
                                onPressed: () {
                                  setState(() {});
                                },
                              )),
                          Text('Nearby Clinics')
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  height: 130, // card height
                  child: Scaffold(
                        body: FutureBuilder(
                            future: getData(),
                            builder: (context, snapshot) {
                              return snapshot.data != null
                                  ? pageViewWidget(snapshot.data)
                                  : Center(child: CircularProgressIndicator());
                            }),
                      )
                  ),
              ]),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    color: Colors.grey[300],
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.contact_page),
                            tooltip: 'Contact Us',
                            onPressed: () {
                              setState(() {});
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.person),
                            tooltip: 'Profile Page',
                            onPressed: () {
                              setState(() {});
                            },
                          ),
                        ])))
          ]),
        ),
      ),
    );
  // This trailing comma makes auto-formatting nicer for build methods.
  }
}
