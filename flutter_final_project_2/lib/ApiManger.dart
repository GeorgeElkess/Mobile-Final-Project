// ignore_for_file: non_constant_identifier_names
/*

dependencies:
  http: ^0.13.5

*/
import 'dart:convert' show json, jsonDecode;

import 'package:http/http.dart' as http;

class PrimaryImage {
  String id = "";
  int width = 0;
  int height = 0;
  String URL = "";
  String captiontext = "";
  PrimaryImage(
      {String Id = "",
      this.URL = "",
      int Width = 0,
      int Height = 0,
      String Captiontext = ""}) {
    id = Id;
    width = Width;
    height = Height;
    captiontext = Captiontext;
  }
  @override
  String toString() {
    return "Id: ${id}, Width: ${width}, Height: ${height}, Caption: ${captiontext}";
  }

  bool get IsSet {
    if (id == "") return false;
    if (URL == "") return false;
    return true;
  }
}

enum MovieType {
  isSeries("Series"),
  isEpisode("Episode"),
  isMovie("Movie");

  const MovieType(this.value);
  final String value;
}

class Movie {
  String id = "";
  PrimaryImage? image;
  MovieType type = MovieType.isMovie;
  String name = "";
  DateTime? releaseDate;
  double AvarageRating = 0;
  Movie(String id,
      {PrimaryImage? image,
      isSeries = false,
      isEpisode = false,
      String name = "",
      DateTime? releaseDate, this.AvarageRating=0}) {
    this.id = id;
    this.image = image;
    if (isSeries) {
      type = MovieType.isSeries;
    }
    if (isEpisode) {
      type = MovieType.isEpisode;
    }
    this.name = name;
    this.releaseDate = releaseDate;
  }
  @override
  String toString() {
    // ignore: todo
    // TODO: implement toString
    return "Id: ${id}, Image: {${image.toString()}}, Type: ${type.value}, Name: ${name}, Date: ${releaseDate.toString()}";
  }

  bool get ImageIsSet {
    if (image == null) return false;
    return image!.IsSet;
  }

  bool get DateIsSet {
    if (releaseDate == null) return false;
    if (releaseDate?.year == 0) return false;
    return true;
  }

  bool get IsSet {
    if (id == "") return false;
    if (name == "") return false;
    return true;
  }
}

enum DateSort {
  // ignore: constant_identifier_names
  Ascending("year.incr"),
  // ignore: constant_identifier_names
  Descending("year.decr");

  const DateSort(this._value);
  final String _value;
}

class APIManger {
  static Movie _FromJsonToObject(String JSON) {
    var Data = jsonDecode(JSON);
    var element = Data['results'];
    return APIManger.FromStringToObject(element);
  }

  static Movie FromStringToObject(element) {
    var image = element['primaryImage'];
    var titleType = element['titleType'];
    var Id = element['id'];
    Movie Result = Movie(element['id'],
        image: image == null
            ? null
            : PrimaryImage(
                Id: image['id'],
                Width: image['width'],
                Height: image['height'],
                URL: image['url'],
                Captiontext: image['caption']['plainText']),
        isEpisode: titleType['isEpisode'],
        isSeries: titleType['isSeries'],
        name: element['titleText']['text'],
        releaseDate: element['releaseDate'] == null
            ? null
            : DateTime(
                element['releaseDate']['year'] ?? 0,
                element['releaseDate']['month'] ?? 1,
                element['releaseDate']['day'] ?? 1,
              ));
    return Result;
  }

  static List<Movie> _FromJsonToObjectsList(String JSON) {
    var AllMovies = json.decode(JSON) as Map<String, dynamic>;
    List Movies = AllMovies['results'];
    var TheMovies = <Movie>[];
    for (int i = 0; i < Movies.length; i++) {
      var element = Movies[i];
      TheMovies.add(APIManger.FromStringToObject(element));
    }
    return TheMovies;
  }

  static Future<List<Movie>> GetAll(
      {int Limit = 50,
      int Page = 1,
      DateSort Sort = DateSort.Descending,
      String Search = "",
      int StartYear = 1950,
      int EndYear = 2023}) async {
    String Link = "titles";
    if (Search != "") {
      Link = "titles/search/title/$Search";
    }
    final Result = await http.get(
        Uri.https("moviesdatabase.p.rapidapi.com", Link, {
          "limit": Limit.toString(),
          "page": Page.toString(),
          "sort": Sort._value,
          "startYear": StartYear.toString(),
          "endYear": EndYear.toString()
        }),
        headers: <String, String>{
          "X-RapidAPI-Key":
              "c6bb78a811mshc1bcce576ad42d9p157ed3jsnf66a775a5f9f",
          "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com",
          "useQueryString": "true"
        });
    if (Result.statusCode != 200) return <Movie>[];
    var TheMovies = APIManger._FromJsonToObjectsList(Result.body);
    return TheMovies;
  }

  static Future<Movie> GetById(String Id) async {
    final Result = await http.get(
        Uri.https("moviesdatabase.p.rapidapi.com", "titles/$Id"),
        headers: <String, String>{
          "X-RapidAPI-Key":
              "c6bb78a811mshc1bcce576ad42d9p157ed3jsnf66a775a5f9f",
          "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com",
          "useQueryString": "true"
        });
    if (Result.statusCode != 200) return Movie("Null");
    var TheMovies = APIManger._FromJsonToObject(Result.body);
    return TheMovies;
  }
}
