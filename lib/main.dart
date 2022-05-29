import 'package:booktopia/search_page.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'books.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

Book book = Book();

class _MyAppState extends State<MyApp> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.black,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 35.0)),
                      ),
                    ],
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (value){
                    username = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                    fillColor: Colors.grey,
                    suffixIcon: Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:  BorderSide(color: Colors.grey ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  onChanged: (value){
                    password = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                    fillColor: Colors.grey,
                    suffixIcon: Icon(Icons.lock),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:  BorderSide(color: Colors.grey ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton(
                        child: Text('Login'),
                        color: Colors.grey,
                        onPressed: () {
                          if(username == "admin"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return SearchPage();
                            }));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
