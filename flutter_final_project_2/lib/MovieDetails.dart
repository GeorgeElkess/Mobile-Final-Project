import 'dart:convert';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ApiManger.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'database.dart';

TextStyle StyTxt(var rate) {
  if (rate) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: Color.fromARGB(255, 167, 177, 184),
      fontSize: 16,
    );
  }
  return TextStyle(
    fontFamily: 'Poppins',
    color: Color.fromARGB(255, 167, 177, 184),
    fontSize: 16,
  );
}


void checkNull(m, img, y, x) {
  if (m!.image != null) {
    img = m!.image!.URL;
  } else {
    img =
        "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930";
  }

  x = x + 1;
}


class MovieDetailsPage extends StatefulWidget {
  MovieDetailsPage({super.key});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPage();
}

class _MovieDetailsPage extends State<MovieDetailsPage> {
  Movie? m;
  //final rd = m!.releaseDate!.day;
  Color cp = Color.fromARGB(255, 75, 57, 239);

  Color cg = Color.fromARGB(255, 87, 99, 108);

  Color fav = Colors.grey;

  var userFav = false;
  double userRat = 3.5;

  IconData LFav = Icons.favorite_border;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    m = arguments['Movie'];
    if (userFav == true) {
      fav = Colors.red;
      LFav = Icons.favorite;
    } else {
      fav = Colors.grey;
      LFav = Icons.favorite_border;
    }

    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Color(0xFFFF0000)),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
                color: cp,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional(1, 0),
                  child: Text(
                    'AGH Movies',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
            actions: [],
            centerTitle: false,
            elevation: 4,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 15, 0),
                      child: IconButton(
                        icon: Icon(
                          LFav,
                          color: fav,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            if (userFav == false) {
                              userFav = true;
                              //fav = Colors.red;
                              //LFav = Icons.favorite;
                            } else {
                              userFav = false;
                              //fav = Colors.grey;
                              //LFav = Icons.favorite_border;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: m!.ImageIsSet
                          ? Image.network(
                              m!.image!.URL,
                              width: 193.8,
                              height: 270,
                              fit: BoxFit.contain,
                            )
                          : Image.asset(
                              "images/pngegg_(3).png",
                              width: 193.8,
                              height: 270,
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    m!.name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: m!.DateIsSet
                      ? Text(m!.releaseDate!.year.toString(),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ))
                      : Text(
                          "Not official released",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(35, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Category:',
                        style: StyTxt(false),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
                        child: Text(
                          'Movie',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: cp,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(35, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Rating:',
                          style: StyTxt(true),
                        ),
                        RatingBar.builder(
                            onRatingUpdate: (value) {
                              userRat = value;
                              print(userRat);
                            },
                            itemBuilder: (context, index) => Icon(
                                  Icons.star_rounded,
                                  color: Colors.yellow,
                                ),
                            direction: Axis.horizontal,
                            initialRating: userRat,
                            allowHalfRating: true,
                            unratedColor: Color(0xFF9E9E9E),
                            itemCount: 5,
                            itemSize: 28,
                            glowColor: cp),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.75, 0),
                  child: Text('Description:', style: StyTxt(false)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(35.5, 5, 20, 0),
                        child: Text(
                          'The moving images of a film are created by photographing actual scenes with a motion-picture camera, by photographing drawings or miniature models using traditional animation techniques, by means of CGI and computer animation, or by a combination of some or all of these techniques, and other visual effects.\n\nBefore the introduction of digital production, series of still images were recorded on a strip of chemically sensitized celluloid (photographic film stock), usually at the rate of 24 frames per second. The images are transmitted through a movie projector at the same rate as they were recorded, with a Geneva drive ensuring that each frame remains still during its short projection time.',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
