import 'package:dio/dio.dart';
import 'package:app_flutter_riverpod/app/features/catalog_movies/data/models/category.model.dart';
import 'package:app_flutter_riverpod/app/features/catalog_movies/domain/entities/category_entity.dart';
import 'package:app_flutter_riverpod/app/features/catalog_movies/domain/repositories/i_categories_movies.repository.dart';

class CategoriesMoviesRepositoryImpl implements ICategoryMoviesRepository {
  final Dio _dio;

  CategoriesMoviesRepositoryImpl(this._dio);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    try {
      final response = await _dio.get('/categories/list');
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => CategoryModel.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw Exception('Erro ao buscar as categorias: ${e.message}');
    }
  }
}