// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_final_project_2/ApiManger.dart';

class DatabaseManger {
  static Future<bool> _CheckUniqe(String CollectionName, String MovieId) async {
    try {
      String? UserId = FirebaseAuth.instance.currentUser?.uid;
      var AllMovies = await FirebaseFirestore.instance
          .collection(CollectionName)
          .where("UserId", isEqualTo: UserId)
          .where("MovieId", isEqualTo: MovieId)
          .get();
      if (AllMovies.docs.isEmpty) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> _GetId(String CollectionName, String MovieId) async {
    try {
      String? UserId = FirebaseAuth.instance.currentUser?.uid;
      var AllMovies = await FirebaseFirestore.instance
          .collection(CollectionName)
          .where("UserId", isEqualTo: UserId)
          .where("MovieId", isEqualTo: MovieId)
          .get();
      if (AllMovies.docs.isEmpty) return null;
      return AllMovies.docs[0].id;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> InFavorits(String MovieId) async {
    return !await DatabaseManger._CheckUniqe("UserFavorits", MovieId);
  }

  static Future<bool> AddFavorits(String MovieId) async {
    String? UserId = FirebaseAuth.instance.currentUser?.uid;
    if (UserId == null) return false;
    try {
      if (await DatabaseManger._CheckUniqe("UserFavorits", MovieId)) {
        await FirebaseFirestore.instance
            .collection('UserFavorits')
            .add({'MovieId': MovieId, 'UserId': UserId});
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  static Future<bool> DeleteFavorits(String MovieId) async {
    String? UserId = FirebaseAuth.instance.currentUser?.uid;
    if (UserId == null) return false;
    try {
      String? Id = await DatabaseManger._GetId("UserFavorits", MovieId);
      if (Id == null) {
        return false;
      }
      await FirebaseFirestore.instance
          .collection("UserFavorits")
          .doc(Id)
          .delete();
    } catch (e) {
      return false;
    }
    return true;
  }

  static Future<bool> AddRating(String MovieId, double Rating) async {
    String? UserId = FirebaseAuth.instance.currentUser?.uid;
    if (UserId == null) return false;
    try {
      if (await DatabaseManger._CheckUniqe("UserRating", MovieId)) {
        await FirebaseFirestore.instance
            .collection('UserRating')
            .add({'MovieId': MovieId, 'UserId': UserId, 'Rating': Rating});
      } else {
        String? Id = await DatabaseManger._GetId("UserRating", MovieId);
        if (Id == null) {
          return false;
        }
        await FirebaseFirestore.instance
            .collection("UserRating")
            .doc(Id)
            .update({'Rating': Rating});
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  static Future<double> GetUserRating(String MovieId) async {
    String? UserId = FirebaseAuth.instance.currentUser?.uid;
    if (UserId == null) return 0;
    try {
      var AllMovies = await FirebaseFirestore.instance
          .collection("UserRating")
          .where("UserId", isEqualTo: UserId)
          .where("MovieId", isEqualTo: MovieId)
          .get();
      List<Movie> Movies = List<Movie>.empty(growable: true);
      var Data = AllMovies.docs[0].data();
      var Rating = Data['Rating'];
      return Rating;
    } catch (e) {
      return 0;
    }
  }

  static Future<double> GetAvarageRating(String MovieId) async {
    try {
      var AllMovies = await FirebaseFirestore.instance
          .collection("UserRating")
          .where("MovieId", isEqualTo: MovieId)
          .get();
      List<Movie> Movies = List<Movie>.empty(growable: true);
      double Total = 0;
      int counter = 0;
      for (var element in AllMovies.docs) {
        var Data = element.data();
        var Rating = Data['Rating'];
        Total += Rating;
        counter++;
      }
      return (Total / counter);
    } catch (e) {
      return 0;
    }
  }

  static Future<List<Movie>> GetFavorits() async {
    try {
      String? UserId = FirebaseAuth.instance.currentUser?.uid;
      var AllMovies = await FirebaseFirestore.instance
          .collection("UserFavorits")
          .where("UserId", isEqualTo: UserId)
          .get();
      List<Movie> Movies = List<Movie>.empty(growable: true);
      for (var element in AllMovies.docs) {
        var Data = element.data();
        var MovieId = Data['MovieId'];
        Movies.add(await APIManger.GetById(MovieId));
      }
      return Movies;
    } catch (e) {
      return [];
    }
  }
}
