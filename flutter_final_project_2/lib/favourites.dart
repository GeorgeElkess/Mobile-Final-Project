// ignore_for_file: must_be_immutable, library_private_types_in_public_api, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_final_project_2/ApiManger.dart';
import 'package:flutter_final_project_2/database.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// void main() async {
//   List<Movie> F = await DatabaseManger.GetFavorits();
//   runApp(FavoritsPage(
//       F: F)); //const FavoritsPage(title: 'Flutter Demo Home Page'),
// }

class FavoritsPage extends StatefulWidget {
  const FavoritsPage({super.key});
  @override
  _FavoritsPageState createState() => _FavoritsPageState();
}

class _FavoritsPageState extends State<FavoritsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Movie>? F;
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    F = arguments['Movies'];
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromRGBO(16, 18, 19, 100),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(16, 18, 19, 100),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(75, 57, 239, 100),
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
              child: Icon(
                Icons.star_rounded,
                color: Color(0xFFFFF700),
                size: 30,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(1, 0),
              child: Text(
                'My Favorites',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: Container(
          color: const Color.fromRGBO(16, 18, 19, 100),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-0.65, -0.65),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: F!.length == 0
                        ? NoMovies()
                        : F!
                            .map((e) => Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/MovieDetailsPage",
                                          arguments: {'Movie': e});
                                    },
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: const Color.fromRGBO(
                                          87, 99, 108, 100),
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(2, 0, 2, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(5, 10, 5, 10),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: e.ImageIsSet
                                                    ? Image.network(
                                                        e.image!.URL,
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.asset(
                                                        'assets/pngegg_(3).png',
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.fill,
                                                      ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(5, 0, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      e.name,
                                                      style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 100),
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Align(
                                                      child: RatingBarIndicator(
                                                        itemBuilder: (BuildContext
                                                                    context,
                                                                int index) =>
                                                            const Icon(
                                                                Icons
                                                                    .star_rounded,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        57,
                                                                        210,
                                                                        192,
                                                                        100)),
                                                        direction:
                                                            Axis.horizontal,
                                                        rating: e.AvarageRating,
                                                        unratedColor:
                                                            const Color(
                                                                0xFF9E9E9E),
                                                        itemCount: 5,
                                                        itemSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Align(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(16, 0, 5, 0),
                                                child: Text(
                                                  e.type.value,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 100)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> NoMovies() {
    return [
      Center(
        child: const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 270, 5, 50),
          child: Text(
            "No Movies are currently added to your favourites",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Color.fromRGBO(255, 255, 255, 100)),
          ),
        ),
      ),
    ];
  }
}
