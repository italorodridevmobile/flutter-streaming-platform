
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/repositories/catalog_movies_repository.impl.dart';
import '../../domain/entities/movie_entity.dart';

final catalogRepositoryProvider = Provider((ref) {
  final dio = ref.watch(apiClientProvider);
  return CatalogMoviesRepositoryImpl(dio);
});

final trendingMoviesProvider = FutureProvider<List<MovieEntity>>((ref) async {
  final repository = ref.watch(catalogRepositoryProvider);
  return repository.getTrendingMovies(page: 1, limit: 3);
});

final moviesPerCategoryProvider = FutureProvider.family<List<MovieEntity>, String>((ref, idCategory) async {
  final repository = ref.watch(catalogRepositoryProvider);
  return repository.getMoviesPerCategory(idCategory, page: 1, limit: 20);
});