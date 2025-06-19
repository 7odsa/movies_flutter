class MovieModelSimilar {
  final int id;
  final String title;
  final String image;
  final double rating;

  MovieModelSimilar({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
  });

  factory MovieModelSimilar.fromJson(Map<String, dynamic> json) {
    return MovieModelSimilar(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['medium_cover_image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}
