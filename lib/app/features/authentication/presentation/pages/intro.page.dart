import 'package:app_flutter_riverpod/app/core/design_system/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

import '../../../../core/design_system/typography/typography.dart';

class ItemData {
  final Color color;
  final Color colorTheme;
  final String logo;
  final String title;
  final String description;

  ItemData({
    required this.color,
    required this.colorTheme,
    required this.logo,
    required this.title,
    required this.description,
  });
}

class IntroPage extends ConsumerStatefulWidget {
  const IntroPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IntroPageState();
}

class _IntroPageState extends ConsumerState<IntroPage> {
  int page = 0;
  late LiquidController liquidController;

  final List<ItemData> data = [
    ItemData(
      color: Colors.white,
      colorTheme: AppColor.primary,
      logo: "Teste",
      title: "Teste",
      description: "",
    ),
    ItemData(
      color: Colors.white,
      colorTheme: AppColor.primary,
      logo: "",
      title: "",
      description: "",
    ),
    ItemData(
      color: Colors.white,
      colorTheme: AppColor.primary,
      logo: "",
      title: "",
      description: "",
    ),
  ];

  ValueNotifier<Color> colorThemeEvent = ValueNotifier<Color>(Colors.white);
  ValueNotifier<int> indexPageEvent = ValueNotifier<int>(0);

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DotsIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color colorTheme;

  const DotsIndicator({
    required this.currentPage,
    required this.totalPages,
    required this.colorTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalPages,
          (index) =>
              Dot(isSelected: index == currentPage, colorTheme: colorTheme),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final bool isSelected;
  final Color colorTheme;

  const Dot({required this.isSelected, required this.colorTheme});

  @override
  Widget build(BuildContext context) {
    double size = isSelected ? 10.0 : 8.0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isSelected ? colorTheme : colorTheme.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
    );
  }
}

class SkipButton extends StatelessWidget {
  final String text;
  final Color colorTheme;
  final VoidCallback onPressed;

  SkipButton({
    required this.text,
    required this.colorTheme,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(foregroundColor: colorTheme),
        child: TextComponent(
          value: text,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColor.button,
          fontFamily: AppFont.UnimedSlab,
        ),
      ),
    );
  }
}
