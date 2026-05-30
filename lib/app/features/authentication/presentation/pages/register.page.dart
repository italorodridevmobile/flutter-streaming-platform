import 'package:app_flutter_riverpod/app/core/utils/navigator_app.dart';
import 'package:app_flutter_riverpod/app/core/utils/progress_app.component.dart';
import 'package:app_flutter_riverpod/app/features/authentication/presentation/pages/login.page.dart';
import 'package:app_flutter_riverpod/app/features/catalog_movies/presentation/pages/catalog_movies.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/alert-dialog-popup.component.dart';
import 'package:flutter_crise/components/button.component.dart';
import 'package:flutter_crise/components/input-text.component.dart';
import 'package:flutter_crise/components/snackbar.component.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design_system/colors/colors.dart';
import '../controllers/register.cotroller.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regsiterState = ref.watch(registerCtrlProvider);

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
                        value: 'Cadastre-se',
                        fontWeight: FontWeight.w800,
                        color: AppColor.primary,
                        fontSize: 22,
                        height: 2,
                      ),
                      TextComponent(
                        value: 'Aproveite o melhor do Streaming',
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: regsiterState.isLoading
                                ? ProgressAppComponent()
                                : ButtonStylizedComponent(
                                    color: AppColor.button,
                                    padding: EdgeInsetsGeometry.all(5),
                                    borderRadius: 100,
                                    label: TextComponent(
                                      value: 'Finalizar cadastro',
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        ref
                                            .read(registerCtrlProvider.notifier)
                                            .createUser(
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
                                                AlertDialogPopupsComponent.show(
                                                  context,
                                                  titleText:
                                                      'Conta criada com sucesso!',
                                                  contentText:
                                                      'Agora basta aproveitar.',
                                                  imageUrl: '',
                                                  confirmText: 'Continuar',

                                                  colorPrimary: AppColor.button,
                                                  fontSizeTitle: 18,
                                                  colorText: AppColor.primary,
                                                  onPressedCancel: () {
                                                    NavigatorApp.replace(context, LoginPage());
                                                  },
                                                  onPressedConfirm: () async {
                                                    NavigatorApp.to(
                                                      context,
                                                      CatalogMoviesPage(),
                                                    );
                                                  },
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
                          NavigatorApp.replace(context, LoginPage());
                        },
                        child: TextComponent(
                          value: 'Já tenho conta. Fazer login',
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
