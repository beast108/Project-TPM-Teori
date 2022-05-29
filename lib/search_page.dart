import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'books.dart';
import 'swipebook.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<VolumeInfo> library = [];
bool loading = true;
bool noresult = false;

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

Book book = Book();

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  getBook1(BuildContext innercontext) async {
    loading = false;
    setState(() {});
    print('App Starting');
    final jsonResponse =
    await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$text'));
    _controller.text = "";
    if (jsonResponse.statusCode == 200) {
      loading = true;
      setState(() {});
    } else {
      noresult = true;
    }

    try {
      var bookie = bookFromJson(jsonResponse.body);
      book = bookie;

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return (Swipebook(
          book: book,
          onPress: () {
            setState(() {
              print(library.length);
            });
          },
        ));
      }));
    } catch (e) {
      print(e);
      book = Book();
      noresult = true;
    }
    print(book.totalItems);
    if (noresult) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("No data found"),
      ));
      noresult = false;
    }
  }

  final _controller = TextEditingController();
  String text;
  SharedPreferences logindata;
  String username;

  void initState() {
    super.initState();
    setState(() {});
    _controller.addListener(() {
      text = _controller.text;
    });
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 40.0,
                  height: 30,
                ),
                Text(
                  "LeBook",
                  style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 60.0,
                          letterSpacing: 6.0)),
                ),
                SizedBox(
                  width: 30.0,
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    padding: EdgeInsets.all(1),
                    color: Colors.white,
                    child: Container(
                      color: Colors.black,
                      child: TextField(
                        selectionHeightStyle: BoxHeightStyle.max,
                        style: GoogleFonts.nunitoSans(
                            textStyle:
                            TextStyle(color: Colors.white, fontSize: 15)),
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.nunitoSans(
                              color: Colors.grey, fontSize: 15.0),
                          hintText: "Enter author name or book name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1.0)),
                          fillColor: Colors.black26,
                          filled: true,
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 40.0,
                          ),
                        ),
                        controller: _controller,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                (loading)
                    ? Builder(
                  builder: (BuildContext innercontext) {
                    return Center(
                      child: Container(
                        padding: EdgeInsets.all(1),
                        color: Colors.grey,
                        child: Container(
                          //padding: EdgeInsets.fromLTRB(0, 0, 7, 7),
                            color: Colors.black,
                            child: RaisedButton(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              colorBrightness: Brightness.light,
                              elevation: 10,
                              child: Text(
                                "Search",
                                style: GoogleFonts.nunitoSans(
                                    textStyle: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white,
                                        fontSize: 20.0)),
                              ),
                              color: Colors.black,
                              onPressed: () {
                                getBook1(context);
                              },
                            )),
                      ),
                    );
                  },
                )
                    : Center(
                    child: Column(
                      children: <Widget>[
                        CircularProgressIndicator(
                          backgroundColor: Colors.black,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Library",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontSize: 30.0)),
                    ),
                  ],
                ),
                (library.length > 0)
                    ? Center(
                  child: Container(
                    color: Colors.black,
                    height: 350.0,
                    width: 500.0,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0),
                        child: ListView.builder(
                          itemCount: library.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              background: Container(color: Colors.red,),
                              key: UniqueKey(),
                              onDismissed: (direction) {},
                              child: ListTile(leading: Image.network(library[index].imageLinks.thumbnail),
                                title: Text(
                                  library[index].title,
                                  style: GoogleFonts.nunitoSans(
                                      textStyle: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white,
                                          fontSize: 15.0)),
                                ),
                                subtitle: Text(
                                  library[index].authors.join(", "),
                                  style: GoogleFonts.nunitoSans(
                                      textStyle: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white,
                                          fontSize: 10.0)),
                                ),),);
                          },
                        ),
                      ),
                    ),
                  ),
                )
                    : Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        "Library Empty",
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                                fontSize: 20.0)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
