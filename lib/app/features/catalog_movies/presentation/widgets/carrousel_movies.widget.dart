import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/design_system/colors/colors.dart';

enum IndicatorType { dots, numbered }

class CarrouselMoviesWidget extends StatefulWidget {
  const CarrouselMoviesWidget({
    required this.imageUrls,
    this.dotColor = Colors.white,
    this.heigthImage,
    this.heigthBox,
    this.type = IndicatorType.dots,
    this.pageController,
    this.onPageChanged,
    this.emptyListWidget,
    this.radiusImage,
    required this.onPageLongClick,
    Key? key,
  }) : super(key: key);

  final double? radiusImage;
  final double? heigthImage;
  final double? heigthBox;
  final List<dynamic> imageUrls;
  final Color dotColor;
  final IndicatorType type;
  final Widget? emptyListWidget;
  final Function(int)? onPageChanged;
  final PageController? pageController;
  final Function(int) onPageLongClick;

  @override
  State<CarrouselMoviesWidget> createState() =>
      _CarrouselMoviesWidgetState();
}

class _CarrouselMoviesWidgetState extends State<CarrouselMoviesWidget> {
  late int activeIndex;

  @override
  void initState() {
    activeIndex = 0;
    super.initState();
  }

  setActiveIndex(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  _buildDottedIndicators() {
    List<Widget> dots = [];
    const double radius = 8;

    for (int i = 0; i < widget.imageUrls.length; i++) {
      dots.add(
        Container(
          height: radius,
          width: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == activeIndex
                ? widget.dotColor
                : widget.dotColor.withOpacity(.6),
          ),
        ),
      );
    }

    dots = intersperse(const SizedBox(width: 6), dots).toList();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dots,
        ),
      ),
    );
  }

  _buildNumberedIndicators() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.33),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 12,
          ),
          child: Text(
            '${(activeIndex + 1)} / ${widget.imageUrls.length}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 20, 22, 41),
      highlightColor: const Color.fromARGB(255, 43, 45, 78),
      child: Container(
        width: double.infinity,
        height: widget.heigthImage,
        color: const Color.fromARGB(255, 30, 32, 59),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: AppColor.neutral3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image,
            color: AppColor.neutral2,
            size: 40,
          ),
          const SizedBox(height: 8),
          TextComponent(
            value: 'Imagem indisponível',
            color: AppColor.danger,
            fontSize: 12,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.imageUrls.isNotEmpty
        ? SizedBox(
            height: widget.heigthBox ?? 200,
            child: Stack(
              children: [
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.imageUrls.length,
                  controller: widget.pageController,
                  onPageChanged: (dynamic value) {
                    setActiveIndex(value);

                    if (widget.onPageChanged != null) {
                      widget.onPageChanged!(value);
                    }
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        widget.onPageLongClick(index);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          widget.radiusImage ?? 0,
                        ),
                        child: widget.imageUrls[index] is File
                            ? Image.file(
                                widget.imageUrls[index],
                                fit: BoxFit.cover,
                                height: widget.heigthImage,
                              )
                            : widget.imageUrls[index]
                                    .contains('https://')
                            ? CachedNetworkImage(
                                imageUrl: widget.imageUrls[index],
                                height: widget.heigthImage,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    _buildShimmer(),
                                errorWidget:
                                    (context, url, error) =>
                                        _buildErrorWidget(),
                              )
                            : Image.asset(
                                widget.imageUrls[index],
                                fit: BoxFit.cover,
                                height: widget.heigthImage,
                              ),
                      ),
                    );
                  },
                ),
                widget.imageUrls.length > 1
                    ? widget.type == IndicatorType.dots
                          ? _buildDottedIndicators()
                          : _buildNumberedIndicators()
                    : Container(),
              ],
            ),
          )
        : widget.emptyListWidget ?? Container();
  }
}

Iterable<T> intersperse<T>(
  T element,
  Iterable<T> iterable,
) sync* {
  final iterator = iterable.iterator;

  if (iterator.moveNext()) {
    yield iterator.current;

    while (iterator.moveNext()) {
      yield element;
      yield iterator.current;
    }
  }
}