class MovieDetailsModel {
  final int id;
  final String title;
  final String titleLong;
  final String year;
  final String description;
  final String image;
  final List<String> screenshots;
  final List<String> genres;
  final double rating;
  final int likes;
  final int views;
  final int runtime;
  final String language;
  final String imdbCode;
  final String mpaRating;
  final String trailerCode;
  final List<CastMember> cast;

  MovieDetailsModel({
    required this.id,
    required this.title,
    required this.titleLong,
    required this.year,
    required this.description,
    required this.image,
    required this.screenshots,
    required this.genres,
    required this.rating,
    required this.likes,
    required this.views,
    required this.runtime,
    required this.language,
    required this.imdbCode,
    required this.mpaRating,
    required this.trailerCode,
    required this.cast,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    final movie = json['data']?['movie'] ?? {};

    final rawScreenshots = [
      movie['background_image'],
      movie['large_cover_image'],
      movie['background_image_original'],
    ];

    final filteredScreenshots = rawScreenshots
        .whereType<String>()
        .where((url) => url.startsWith('http'))
        .toList();

    return MovieDetailsModel(
      id: movie['id'] ?? 0,
      title: movie['title'] ?? '',
      titleLong: movie['title_long'] ?? '',
      year: movie['year']?.toString() ?? '',
      description: movie['description_full'] ?? '',
      image: movie['large_cover_image'] ?? '',
      screenshots: filteredScreenshots,
      genres: List<String>.from(movie['genres'] ?? []),
      rating: (movie['rating'] ?? 0).toDouble(),
      likes: movie['like_count'] ?? 0,
      views: movie['download_count'] ?? 0,
      runtime: movie['runtime'] ?? 0,
      language: movie['language'] ?? '',
      imdbCode: movie['imdb_code'] ?? '',
      mpaRating: movie['mpa_rating'] ?? '',
      trailerCode: movie['yt_trailer_code'] ?? '',
      cast: (movie['cast'] as List?)?.map((e) => CastMember.fromJson(e)).toList() ?? [],
    );
  }
}

class CastMember {
  final String name;
  final String characterName;
  final String? urlSmallImage;

  CastMember({
    required this.name,
    required this.characterName,
    this.urlSmallImage,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) {
    return CastMember(
      name: json['name'] ?? '',
      characterName: json['character_name'] ?? '',
      urlSmallImage: json['url_small_image'],
    );
  }
}
