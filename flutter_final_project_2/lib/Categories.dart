// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'ApiManger.dart';
import 'MyClasses.dart';
import 'database.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Movie> Movies = List<Movie>.empty(growable: true);
  late MovieType Type = MovieType.isMovie;
  int PageNumber = 1;
  Future<void> SetData({String Search = ""}) async {
    List<Movie> x = List<Movie>.empty(growable: true);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    Type = arguments['Type'];
    while (x.length < 20) {
      try {
        List<Movie> Temp =
            await APIManger.GetAll(Page: PageNumber, Search: Search);
        for (var element in Temp) {
          print(element.AvarageRating);
          if (element.type == Type) {
            x.add(element);
          }
        }
        PageNumber++;
      } catch (e) {
        PageNumber = 0;
        break;
      }
    }
    Movies = x;
  }

  final Search = TextEditingController();
  @override
  void dispose() {
    Search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    Type = arguments['Type'];
    AppBar appBar = AppBar(
      backgroundColor: Colors.grey.shade800,
      title: Row(
        children: [
          const Icon(
            Icons.category,
            color: Colors.white,
            size: 40,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              Type.value,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      elevation: 0,
      // leading: const Icon(Icons.menu, color: Colors.deepPurpleAccent),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: GestureDetector(
            child: const Icon(
              Icons.star,
              color: Color.fromARGB(255, 255, 215, 0),
              size: 40,
            ),
            onTap: () async {
              List<Movie> list = await DatabaseManger.GetFavorits();
              Navigator.pushNamed(context, "/Favorits",
                  arguments: {'Movies': list});
            },
          ),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      backgroundColor: const Color.fromARGB(221, 16, 16, 16),
      body: Container(
          color: const Color.fromARGB(221, 16, 16, 16),
          height:
              MediaQuery.of(context).size.height - appBar.preferredSize.height,
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
                child: TextInput(
                  autoCorrect: true,
                  PlaceHolder: "Search",
                  TextControler: Search,
                  OnTextChange: (text) {
                    setState(() {
                      PageNumber = 1;
                    });
                  },
                ),
              ),
              FutureBuilder(
                future: SetData(Search: Search.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return TheBody();
                  } else {
                    return Center(
                      child: LoadingAnimationWidget.flickr(
                          leftDotColor: const Color.fromARGB(255, 0, 87, 215),
                          rightDotColor: const Color.fromARGB(255, 254, 1, 120),
                          size: 30),
                    );
                  }
                },
              ),
            ],
          ))),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisSize: MainAxisSize.max,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FloatingActionButton(
              heroTag: 'btn1',
              onPressed: () {
                setState(() {
                  if (PageNumber > 0) PageNumber--;
                });
              },
              child: const Icon(Icons.navigate_before),
            ),
            FloatingActionButton(
              heroTag: 'btn2',
              onPressed: () {
                setState(() {
                  PageNumber = PageNumber;
                });
              },
              child: const Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniStartDocked,
    );
  }

  Widget TheBody() {
    if (Movies.isEmpty) {
      return Center(
        child: Text(
          "No ${Type.value} Found",
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: Movies.map((e) {
        print(e.AvarageRating);
        return GestureDetector(
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
                          padding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(e.name,
                                  style: const TextStyle(color: Colors.white)),
                              RatingBarIndicator(
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    const Icon(Icons.star_rounded,
                                        color:
                                            Color.fromRGBO(57, 210, 192, 100)),
                                direction: Axis.horizontal,
                                rating: e.AvarageRating,
                                unratedColor: const Color(0xFF9E9E9E),
                                itemCount: 5,
                                itemSize: 20,
                              ),
                            ],
                          )),
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
        );
      }).toList(),
    );
  }
}
