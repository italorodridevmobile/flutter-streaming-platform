import 'package:app_flutter_riverpod/app/core/design_system/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:shimmer/shimmer.dart';

class CardMovieWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const CardMovieWidget({
    super.key,
    required this.imageUrl,
    this.width = 130,
    this.height = 200,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,

          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 20, 22, 41),
            highlightColor: const Color.fromARGB(255, 43, 45, 78),
            child: Container(
              width: width,
              height: height,
              color: const Color.fromARGB(255, 30, 32, 59),
            ),
          ),

          errorWidget: (context, url, error) => Container(
            width: width,
            height: height,
            color: AppColor.neutral3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.broken_image, color: AppColor.neutral2, size: 40),
                const SizedBox(height: 8),
                TextComponent(
                  value: 'Imagem indisponível',
                  color: AppColor.danger,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
