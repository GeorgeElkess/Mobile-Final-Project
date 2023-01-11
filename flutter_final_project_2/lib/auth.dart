import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ApiManger.dart';
import 'HomePage.dart';
import 'login.dart';

// ignore: must_be_immutable
class Auth extends StatelessWidget {
  // ignore: non_constant_identifier_names
  Auth({super.key, required this.Result});
  // ignore: non_constant_identifier_names
  List<Movie> Result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return HomePage(Movies: Result);
          } else {
            return Login();
          }
        },
      ),
    );
  }
}

