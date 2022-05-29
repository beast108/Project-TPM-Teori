import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class description extends StatelessWidget {
  String para;
  description({this.para});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 20.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Description",
              style: GoogleFonts.lato(
                  textStyle: TextStyle(fontSize: 25.0), color: Colors.white)),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                  child: Text('$para',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(fontSize: 20.0),
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ));
  }
}