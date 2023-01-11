// ignore_for_file: non_constant_identifier_names

import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project_2/database.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'ApiManger.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  List<Movie> Movies;
  // ignore: non_constant_identifier_names
  HomePage({super.key, required this.Movies});

  @override
  // ignore: no_logic_in_create_state
  State<HomePage> createState() => _HomePageState(Movies);
}

class _HomePageState extends State<HomePage> {
  late List<Movie> Movies;
  late List<Movie> _MoviesWithImages;
  _HomePageState(this.Movies) {
    _MoviesWithImages = List<Movie>.empty(growable: true);
    for (int i = 0; i < Movies.length; i++) {
      var Movie = Movies[i];
      if (Movie.ImageIsSet) {
        _MoviesWithImages.add(Movie);
      }
    }
    for (int i = 0; i < Movies.length && _MoviesWithImages.length < 6; i++) {
      _MoviesWithImages.add(Movies[i]);
    }
  }
  int pageNumber = 1;
  Future<bool> GetData() async {
    Movies = await APIManger.GetAll(Page: pageNumber);
    return true;
  }

  bool refresh = false;
  int ImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade800,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () async {
                    print("Done");
                    await FirebaseAuth.instance.signOut();
                  },
                  child:
                      const Icon(Icons.logout, color: Colors.white, size: 40)),
              GestureDetector(
                onTap: () async {
                  print(await DatabaseManger.GetAvarageRating("tt25467838"));
                },
                child: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: GestureDetector(
                  child: const Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 255, 215, 0),
                    size: 40,
                  ),
                  onTap: () {
                    print("Go to Favorits");
                  },
                ),
              )
            ],
          ),
          elevation: 0,
        ),
        body: Container(
          color: Colors.grey.shade800,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider(
                    items: [0, 1, 2, 3, 4, 5]
                        .map((i) => GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/MovieDetailsPage",
                                    arguments: {'Movie': _MoviesWithImages[i]});
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          // blurRadius: 7,
                                        )
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Image.network(
                                        _MoviesWithImages[i].image!.URL,
                                        width: 190,
                                        height: 146,
                                        fit: BoxFit.contain,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 3, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              _MoviesWithImages[i].name,
                                              style: const TextStyle(
                                                  color: Colors.white70),
                                            ),
                                            // Text(
                                            //   _MoviesWithImages[i].type.value,
                                            //   style: const TextStyle(
                                            //       color: Colors.white70),
                                            // ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 0.8,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) =>
                          setState(() => ImageIndex = index),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: CarouselIndicator(
                      count: 6,
                      index: ImageIndex,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Container(
                        // width: 2000,
                        // height: 1000,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(221, 16, 16, 16),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x34000000),
                                  offset: Offset(0, -2))
                            ],
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 16, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Categories",
                                    style:
                                        TextStyle(color: Colors.grey.shade400),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 12, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      width: 100,
                                      height: 95,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade800,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/Movies_2.png",
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 8, 0, 0),
                                            child: Text(
                                              "Movies",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/Categories", arguments: {
                                        'Type': MovieType.isMovie
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      width: 100,
                                      height: 95,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade800,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/TV_Shows-removebg-preview.png",
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 8, 0, 0),
                                            child: Text(
                                              "Series",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/Categories", arguments: {
                                        'Type': MovieType.isSeries
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      width: 100,
                                      height: 95,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade800,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/Episode.png",
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 8, 0, 0),
                                            child: Text(
                                              "Episode",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/Categories", arguments: {
                                        'Type': MovieType.isEpisode
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 16, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "General",
                                    style:
                                        TextStyle(color: Colors.grey.shade400),
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.refresh,
                                      color: Colors.grey.shade400,
                                      size: 20,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        pageNumber++;
                                        refresh = true;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            refresh == false
                                ? BuildMovies()
                                : FutureBuilder(
                                    future: GetData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        refresh = false;
                                        return BuildMovies();
                                      } else {
                                        return Loding();
                                      }
                                    },
                                  )
                          ],
                        )),
                  )
                ]),
          ),
        ));
  }

  Widget Loding() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LoadingAnimationWidget.flickr(
            leftDotColor: const Color.fromARGB(255, 0, 87, 215),
            rightDotColor: const Color.fromARGB(255, 254, 1, 120),
            size: 30),
        const SizedBox(
          height: 1000,
          width: 500,
        )
      ],
    );
  }

  Widget BuildMovies() {
    return Column(
        mainAxisSize: MainAxisSize.max,
        children: Movies.map((e) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/MovieDetailsPage",
                    arguments: {'Movie': e});
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
                child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: e.ImageIsSet
                                ? Image.network(
                                    e.image!.URL,
                                    fit: BoxFit.contain,
                                    height: 80,
                                    width: 100,
                                  )
                                : Image.asset(
                                    "assets/pngegg_(3).png",
                                    fit: BoxFit.contain,
                                    height: 80,
                                    width: 100,
                                  )),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                              child: Text(e.name,
                                  style: const TextStyle(color: Colors.white))),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: Text(
                              e.type.value,
                              style: const TextStyle(color: Colors.white),
                            ))
                      ],
                    )),
              ),
            )).toList());
  }
}
