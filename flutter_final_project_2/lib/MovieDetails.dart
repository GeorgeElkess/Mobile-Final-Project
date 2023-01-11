// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'ApiManger.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

TextStyle StyTxt(var rate) {
  if (rate) {
    return const TextStyle(
      fontFamily: 'Poppins',
      color: Color.fromARGB(255, 167, 177, 184),
      fontSize: 16,
    );
  }
  return const TextStyle(
    fontFamily: 'Poppins',
    color: Color.fromARGB(255, 167, 177, 184),
    fontSize: 16,
  );
}

// ignore: must_be_immutable
class MovieDetailsPage extends StatelessWidget {
  MovieDetailsPage({super.key});

  Movie? m;
  Color cp = const Color.fromARGB(255, 75, 57, 239);
  Color cg = const Color.fromARGB(255, 87, 99, 108);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    m = arguments['Movie'];
    print(m?.image?.URL);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFFFF0000)),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: cp,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
            print('IconButton pressed ...');
          },
        ),
        title: const Align(
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
        actions: [],
        centerTitle: false,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 25),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    m!.image!.URL,
                    width: 193.8,
                    height: 270,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Text(
                      m!.image!.captiontext,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(35, 20, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Category:',
                    style: StyTxt(false),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
                    child: Text(
                      m!.type.value,
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
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(35, 0, 0, 0),
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
                          print(value);
                        },
                        itemBuilder: (context, index) => const Icon(
                              Icons.star_rounded,
                              color: Colors.yellow,
                            ),
                        direction: Axis.horizontal,
                        initialRating: 0,
                        allowHalfRating: true,
                        unratedColor: const Color(0xFF9E9E9E),
                        itemCount: 5,
                        itemSize: 28,
                        glowColor: cp),
                  ],
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.75, 0),
              child: Text('Description:', style: StyTxt(false)),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: const [
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
    );
  }
}
