import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../design_system/colors/colors.dart';

class ProgressAppComponent extends StatefulWidget {
  const ProgressAppComponent({super.key});

  @override
  State<ProgressAppComponent> createState() => _ProgressAppComponentState();
}

class _ProgressAppComponentState extends State<ProgressAppComponent> {
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: index.isEven ? AppColor.primary : AppColor.primaryLight,
          ),
        );
      },
    );
  }
}
