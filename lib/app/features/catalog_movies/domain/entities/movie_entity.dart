class MovieEntity {
  final String id;
  final String title;
  final String description;
  final List<String> categoryIds;
  final double price;
  final String year;
  final String duration;
  final String imageUrl;
  final String urlMovie;

  MovieEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryIds,
    required this.price,
    required this.duration,
    required this.year,
    required this.imageUrl,
    required this.urlMovie
  });
}