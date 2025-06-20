class ResponseMovie {
  String? status;
  String? statusMessage;
  MovieList? data;

  ResponseMovie({this.status, this.statusMessage, this.data});

  ResponseMovie.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? MovieList.fromJson(json['data']) : null;
  }
}

class MovieList {
  int? movieCount;
  int? limit;
  int? pageNumber;
  List<MovieDM>? movies;

  MovieList({this.movieCount, this.limit, this.pageNumber, this.movies});

  MovieList.fromJson(Map<String, dynamic> json) {
    movieCount = json['movie_count'];
    limit = json['limit'];
    pageNumber = json['page_number'];
    if (json['movies'] != null) {
      movies = <MovieDM>[];
      json['movies'].forEach((v) {
        movies!.add(MovieDM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['movie_count'] = movieCount;
    data['limit'] = limit;
    data['page_number'] = pageNumber;
    if (movies != null) {
      data['movies'] = movies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MovieDM {
  int? id;
  String? url;
  String? imdbCode;
  String? title;
  int? year;
  dynamic rating;
  int? runtime;
  List<String>? genres;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? dateUploaded;

  MovieDM({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.dateUploaded,
  });

  MovieDM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    year = json['year'];
    rating = json['rating'];
    runtime = json['runtime'];
    genres = json['genres'].cast<String>();
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    dateUploaded = json['date_uploaded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['imdb_code'] = imdbCode;
    data['title'] = title;
    data['year'] = year;
    data['rating'] = rating;
    data['runtime'] = runtime;
    data['genres'] = genres;
    data['background_image'] = backgroundImage;
    data['background_image_original'] = backgroundImageOriginal;
    data['small_cover_image'] = smallCoverImage;
    data['medium_cover_image'] = mediumCoverImage;
    data['large_cover_image'] = largeCoverImage;
    data['date_uploaded'] = dateUploaded;
    return data;
  }

  static List<MovieDM> listFromJson(json) {
    List<dynamic> data = (json['data'] as List<dynamic>);
    List<MovieDM> movies = [];
    for (var movie in data) {
      int year = int.parse(movie['year'] as String);
      int id = int.parse(movie['movieId']);
      movies.add(
        MovieDM(
          id: id,
          title: movie['name'],
          rating: movie['rating'],
          mediumCoverImage: movie['imageURL'],
          year: year,
        ),
      );
    }
    return movies;
  }
}
