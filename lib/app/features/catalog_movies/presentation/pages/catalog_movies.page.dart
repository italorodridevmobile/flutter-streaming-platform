import 'package:app_flutter_riverpod/app/core/design_system/colors/colors.dart';
import 'package:app_flutter_riverpod/app/core/utils/navigator_app.dart';
import 'package:app_flutter_riverpod/app/core/utils/progress_app.component.dart';
import 'package:app_flutter_riverpod/app/features/catalog_movies/domain/entities/movie_entity.dart';
import 'package:app_flutter_riverpod/app/features/catalog_movies/presentation/controllers/catalog_movies.providers.dart';
import 'package:app_flutter_riverpod/app/features/catalog_movies/presentation/widgets/card_category.widget.dart';
import 'package:app_flutter_riverpod/app/features/detail_movie/presentation/pages/detail_movie.page.dart';
import 'package:app_flutter_riverpod/app/features/profile/presentation/pages/profile.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/carrousel-image.component.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../profile/domain/entities/profile.entity.dart';
import '../../../profile/presentation/controllers/profile.provider.dart';
import '../controllers/categories_movies.providers.dart';
import '../widgets/card_movie.widget.dart';

class CatalogMoviesPage extends ConsumerStatefulWidget {
  const CatalogMoviesPage({super.key});

  @override
  ConsumerState<CatalogMoviesPage> createState() => _CatalogMoviesPageState();
}

class _CatalogMoviesPageState extends ConsumerState<CatalogMoviesPage> {
  final Map<String, GlobalKey> _sectionKeys = {};

  void _scrollToSection(String categoryId) {
    final key = _sectionKeys[categoryId];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }
  }

  String _getSubtitleByCategory(String title) {
    switch (title.toLowerCase().trim()) {
      case 'ação':
        return 'Explosões, perseguições e muita adrenalina';
      case 'comédia':
        return 'Filmes para dar boas risadas';
      case 'drama':
        return 'Histórias emocionantes e marcantes';
      case 'ficção científica':
        return 'Viagens espaciais e mundos futuristas';
      case 'terror':
        return 'Prepare-se para muitos sustos';
      case 'documentários':
        return 'Conhecimento e histórias reais';
      case 'documentário':
        return 'Conhecimento e histórias reais';
      default:
        return 'Catálogo de filmes selecionados para você';
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryMoviesState = ref.watch(categoriesMoviesProvider);
    final trendingMoviesState = ref.watch(trendingMoviesProvider);
    final currentProfile = ref.watch(selectedProfileProvider);

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColor.dark,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildToolbar(state: currentProfile),
                buildTrendingMovies(state: trendingMoviesState),
                buildCategories(state: categoryMoviesState),
                categoryMoviesState.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(child: ProgressAppComponent()),
                  ),
                  error: (error, stack) => const SizedBox.shrink(),
                  data: (categories) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];

                        _sectionKeys.putIfAbsent(
                          category.id,
                          () => GlobalKey(),
                        );

                        final moviesState = ref.watch(
                          moviesPerCategoryProvider(category.id),
                        );

                        return buildSection(
                          id: category.id,
                          title: category.title,
                          subtitle: _getSubtitleByCategory(category.title),
                          state: moviesState,
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildToolbar({required ProfileEntity? state}) {
    final String firebaseUid = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (state == null)
            GestureDetector(
              onTap: () {
                NavigatorApp.replace(
                  context,
                  ProfileSelectionPage(accountId: firebaseUid),
                );
              },
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white24, width: 1.5),
                      image: DecorationImage(
                        image: AssetImage('assets/images/avatar_01.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextComponent(
                    value: 'Perfil',
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          if (state != null)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white24, width: 1.5),
                      image: DecorationImage(
                        image: AssetImage(state.avatarAssetPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextComponent(
                    value: state.name,
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget buildTrendingMovies({required AsyncValue state}) {
    return SizedBox(
      height: 300,
      child: state.when(
        data: (listItems) {
          return CarrouselImageComponent(
            imageUrls: listItems.map((MovieEntity el) => el.imageUrl).toList(),
            onPageLongClick: (index) {
              NavigatorApp.to(context, DetailMoviePage(data: listItems[index]));
            },
          );
        },
        error: (error, stack) => Center(
          child: TextComponent(
            value: 'Erro ao carregar destaques',
            color: AppColor.danger,
          ),
        ),
        loading: () => Center(child: ProgressAppComponent()),
      ),
    );
  }

  Widget buildCategories({required AsyncValue state}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: state.when(
              data: (categories) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CardCategoryWidget(
                      title: category.title,
                      onTap: () {
                        _scrollToSection(category.id);
                      },
                    );
                  },
                );
              },
              loading: () => Center(child: ProgressAppComponent()),
              error: (error, stack) => Center(
                child: TextComponent(
                  value: 'Erro ao carregar categorias',
                  color: AppColor.danger,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSection({
    required String id,
    required AsyncValue state,
    required String title,
    required String subtitle,
  }) {
    return Column(
      key: _sectionKeys[id],
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  TextComponent(
                    value: title,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ],
              ),
              Row(
                children: [
                  TextComponent(
                    value: subtitle,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: state.when(
            loading: () => Center(child: ProgressAppComponent()),
            data: (movies) {
              if (movies.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhum filme disponível nesta categoria.',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                );
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CardMovieWidget(
                      imageUrl: movie.imageUrl,
                      onTap: () {
                        NavigatorApp.to(context, DetailMoviePage(data: movie));
                      },
                    ),
                  );
                },
              );
            },
            error: (error, stack) => Center(
              child: TextComponent(
                value: 'Erro ao carregar filmes',
                color: AppColor.danger,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
