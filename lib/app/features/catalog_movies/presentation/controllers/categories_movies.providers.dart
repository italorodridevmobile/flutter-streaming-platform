
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/repositories/categories_movies_repository.impl.dart';
import '../../domain/entities/category_entity.dart';

final categoriesMoviesRepositoryProvider = Provider((ref) {
  final dio = ref.watch(apiClientProvider);
  return CategoriesMoviesRepositoryImpl(dio);
});

final categoriesMoviesProvider = FutureProvider<List<CategoryEntity>>((ref) async {
  final repository = ref.watch(categoriesMoviesRepositoryProvider);
  return repository.getCategories();
});
