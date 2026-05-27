
import '../entities/movie_entity.dart';

abstract class ICatalogMoviesRepository {
  Future<List<MovieEntity>> getTrendingMovies({required int page, required int limit});
  Future<List<MovieEntity>> getMoviesPerCategory(String idCategory, {required int page, required int limit});
}