import 'package:flutter/material.dart';
import 'package:flutter_crise/components/text.component.dart';

class CardCategoryWidget extends StatelessWidget {
  String title;
  final VoidCallback? onTap;

  CardCategoryWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Center(
          child: TextComponent(
          value: title,
          fontWeight: FontWeight.w800,
          fontSize: 14,
          color: Colors.white,
        ),
        ),
      ),
    );
  }
}
