import 'package:app_flutter_riverpod/app/core/design_system/colors/colors.dart';
import 'package:app_flutter_riverpod/app/core/utils/navigator_app.dart';
import 'package:app_flutter_riverpod/app/core/utils/progress_app.component.dart';
import 'package:app_flutter_riverpod/app/features/catalog_movies/data/models/movie.model.dart';
import 'package:app_flutter_riverpod/app/features/player/presentation/pages/player.page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/button.component.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailMoviePage extends ConsumerWidget {
  final MovieModel data;
  const DetailMoviePage({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: data.imageUrl,
                      width: double.infinity,
                      height: screenHeight * 0.55,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColor.neutral2,
                        child: const Center(
                          child: ProgressAppComponent()
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColor.neutral2,
                        child: Center(
                          child: Icon(
                            Icons.broken_image,
                            color: AppColor.neutral1,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColor.background,
                              AppColor.background.withOpacity(0.1),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.4, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextComponent(
                        value: data.title,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildBadge(data.year),
                          const SizedBox(width: 8),
                          _buildBadge(data.duration),
                          const SizedBox(width: 8),
                          _buildBadge('HD | 4k | Dolby atmos', isBordered: true),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ButtonStylizedComponent(
                        color: AppColor.button,
                        padding: EdgeInsetsGeometry.all(5),
                        borderRadius: 100,
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 26,
                            ),
                            SizedBox(width: 5),
                            TextComponent(value: 'Assistir trailer', color: Colors.white),
                          ],
                        ),
                        onPressed: () {
                          NavigatorApp.to(context, PlayerPage(data: data));
                        },
                      ),
                      const SizedBox(height: 24),
                      TextComponent(
                        value: 'Sinopse',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      TextComponent(
                        value:
                            data.description,
                        fontSize: 14,
                        color: AppColor.neutral1,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, {bool isBordered = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isBordered ? Colors.transparent : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: isBordered
            ? Border.all(color: Colors.white.withOpacity(0.4), width: 1)
            : null,
      ),
      child: TextComponent(
        value: text,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }
}
