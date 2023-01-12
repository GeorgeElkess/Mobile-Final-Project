// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project_2/favourites.dart';
import 'package:flutter_final_project_2/firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart'
    show FlutterNativeSplash;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ApiManger.dart';
import 'Categories.dart';
import 'HomePage.dart';
import 'MovieDetails.dart';
import 'Regester.dart';
import 'auth.dart';
import 'package:firebase_core/firebase_core.dart';
/*
dependencies:
  http: ^0.13.5
  flutter_native_splash: ^2.2.16
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.2
  carousel_slider: ^4.2.1
  carousel_indicator: ^1.0.6
  loading_animation_widget:
assets:
    - assets/pngegg_(3).png
    - assets/Movies_2.png
    - assets/TV_Shows-removebg-preview.png
    - assets/Episode.png
*/

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  List<Movie> Result = await APIManger.GetAll();
  FlutterNativeSplash.remove();
  runApp(MaterialApp(
      title: "Flutter Mobile",
      initialRoute: '/',
      routes: {
        '/': (context) => Auth(Result: Result),
        '/Regester': (context) => const Regester(),
        '/HomePage': (context) => HomePage(Movies: Result),
        '/Categories': (context) => const CategoriesPage(),
        '/MovieDetailsPage':(context) => MovieDetailsPage(), 
        '/Favorits':(context) => const FavoritsPage()
      },
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          textTheme:
              const TextTheme(headline4: TextStyle(color: Colors.white)))));

}

