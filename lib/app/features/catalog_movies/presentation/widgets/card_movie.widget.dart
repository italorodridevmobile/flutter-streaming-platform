import 'package:app_flutter_riverpod/app/core/design_system/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_crise/components/text.component.dart';

import '../../../../core/utils/progress_app.component.dart';

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
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: AppColor.neutral3,
            child: const Center(
              child: ProgressAppComponent(),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: AppColor.neutral3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.broken_image, color: AppColor.neutral2, size: 40),
                SizedBox(height: 8),
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
