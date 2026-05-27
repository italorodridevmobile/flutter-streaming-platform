import 'package:app_flutter_riverpod/app/core/utils/navigator_app.dart';
import 'package:app_flutter_riverpod/app/features/authentication/presentation/controllers/login.controller.dart';
import 'package:app_flutter_riverpod/app/features/authentication/presentation/pages/login.page.dart';
import 'package:app_flutter_riverpod/app/features/catalog_movies/presentation/pages/catalog_movies.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design_system/colors/colors.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {

  @override
  void initState() {
    super.initState();
    _checkAuthenticationAndNavigate();
  }

  void _checkAuthenticationAndNavigate() {
    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;
      final authState = ref.read(authStateProvider).value;

      if (authState != null) {
        NavigatorApp.replace(context, const CatalogMoviesPage());
      } else {
        NavigatorApp.replace(context, LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColor.dark,
        body: Center(
          child: TextComponent(
            value: 'ItMax',
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 60,
          ),
        ),
      ),
    );
  }
}