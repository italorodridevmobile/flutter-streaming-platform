import 'package:dio/dio.dart';
import 'package:app_flutter_riverpod/app/features/catalog_movies/data/models/movie.model.dart';
import 'package:app_flutter_riverpod/app/features/catalog_movies/domain/entities/movie_entity.dart';
import 'package:app_flutter_riverpod/app/features/catalog_movies/domain/repositories/i_catalog_movies_repository.dart';

class CatalogMoviesRepositoryImpl implements ICatalogMoviesRepository {
  final Dio _dio;

  CatalogMoviesRepositoryImpl(this._dio);

  @override
  Future<List<MovieEntity>> getTrendingMovies({required int page, required int limit}) async {
    try {
      final response = await _dio.get('/movies/list',
      queryParameters: {
        'page': page,
        'limit': limit
      });
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => MovieModel.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw Exception('Erro ao buscar filmes em alta: ${e.message}');
    }
  }

  @override
  Future<List<MovieEntity>> getMoviesPerCategory(String idCategory, {required int page, required int limit}) async {
    try {
      final response = await _dio.get('/movies/list/$idCategory',
      queryParameters: {
        'page': page,
        'limit': limit
      });
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => MovieModel.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw Exception('Erro ao buscar filmes por categoria: ${e.message}');
    }
  }
}