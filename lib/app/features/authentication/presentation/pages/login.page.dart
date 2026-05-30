import 'package:app_flutter_riverpod/app/core/utils/navigator_app.dart';
import 'package:app_flutter_riverpod/app/core/utils/progress_app.component.dart';
import 'package:app_flutter_riverpod/app/features/authentication/presentation/pages/register.page.dart';
import 'package:app_flutter_riverpod/app/features/authentication/presentation/pages/reset_password.page.dart';
import 'package:app_flutter_riverpod/app/features/catalog_movies/presentation/pages/catalog_movies.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/button.component.dart';
import 'package:flutter_crise/components/input-text.component.dart';
import 'package:flutter_crise/components/snackbar.component.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design_system/colors/colors.dart';
import '../controllers/login.controller.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginCtrlProvider);

    return PopScope(
      canPop: false,
      child: Scaffold(
      backgroundColor: AppColor.dark,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/movies_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColor.dark, AppColor.dark.withAlpha(60)],
                  stops: [0.6, 0.9],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextComponent(
                        value: 'ItMax',
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 55,
                      ),
                      const SizedBox(height: 8),
                      InputTextComponent(
                        textEditingController: emailCtrl,
                        labelText: 'E-mail',
                        hintText: 'Informe seu e-mail',
                        textColor: Colors.white,
                        borderColor: Colors.white,
                        borderRadius: 16,
                        onChanged: (event) {},
                      ),
                      const SizedBox(height: 24),
                      InputTextComponent(
                        textEditingController: passwordCtrl,
                        labelText: 'Senha',
                        hintText: 'Informe sua senha',
                        textColor: Colors.white,
                        borderColor: Colors.white,
                        borderRadius: 16,
                        obscureText: true,
                        onChanged: (event) {},
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              NavigatorApp.to(context, ResetPasswordPage());
                            },
                            child: TextComponent(
                              value: 'Esqueci a senha',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: loginState.isLoading
                                ? ProgressAppComponent()
                                : ButtonStylizedComponent(
                                    color: AppColor.button,
                                    padding: EdgeInsetsGeometry.all(5),
                                    borderRadius: 100,
                                    label: TextComponent(
                                      value: 'Entrar',
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        ref
                                            .read(loginCtrlProvider.notifier)
                                            .signIn(
                                              email: emailCtrl.text,
                                              password: passwordCtrl.text,
                                              onError: (error) async {
                                                await SnackbarComponent.show(
                                                  context,
                                                  text: error,
                                                  backgroundColor:
                                                      AppColor.primary,
                                                  textColor: Colors.white,
                                                );
                                              },
                                              onSuccess: (userCredential) {
                                                NavigatorApp.replace(
                                                  context,
                                                  CatalogMoviesPage(),
                                                );
                                              },
                                            );
                                      }
                                    },
                                  ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          NavigatorApp.to(context, RegisterPage());
                        },
                        child: TextComponent(
                          value: 'Novo por aqui? Cadastre-se',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
