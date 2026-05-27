import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.id,
    required super.title,
    required super.description,
    required super.categoryIds,
    required super.price,
    required super.year,
    required super.duration,
    required super.imageUrl,
    required super.urlMovie,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'ND',
      description: json['description']?.toString() ?? 'ND',
      
      categoryIds: json['category_ids'] != null
          ? List<String>.from(json['category_ids'] as Iterable)
          : [],
          
      price: json['price'] != null 
          ? (json['price'] as num).toDouble() 
          : 0.0,
          
      year: json['year']?.toString() ?? 'ND',
      duration: json['duration']?.toString() ?? 'ND',
      imageUrl: json['image_url']?.toString() ?? 'ND',
      urlMovie: json['url_movie']?.toString() ?? 'ND',
    );
  }
}