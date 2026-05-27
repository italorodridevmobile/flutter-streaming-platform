
import '../entities/category_entity.dart';

abstract class ICategoryMoviesRepository {
  Future<List<CategoryEntity>> getCategories();
}
