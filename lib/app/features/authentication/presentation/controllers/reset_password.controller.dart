import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ResetPasswordController extends StateNotifier<AsyncValue> {
  ResetPasswordController() : super(const AsyncValue.data(null));
  FirebaseAuth auth = FirebaseAuth.instance;

  FutureOr<AsyncValue> build() {
    throw UnimplementedError();
  }

  Future<void> resetPassword({
    required String email,
    required Function(String error) onError,
    required Function(void) onSuccess,
  }) async {
    final e = email.trim();

    if (e.isEmpty) {
      onError('Insira seu e-mail!');
    } else {
      state = const AsyncLoading();

      state = await AsyncValue.guard(() async {
        final res = await auth.sendPasswordResetEmail(
          email: e
        );
        onSuccess(res);
      });

      if (state.hasError) {
        final error = state.error;
        String msg = 'Ocorreu um erro inesperado. Tente novamente.';

        if (error is FirebaseAuthException) {
          switch (error.code) {
            case 'invalid-email':
              msg = 'O formato do e-mail informado é inválido.';
              break;
            case 'user-disabled':
              msg = 'Este usuário foi desativado pela administração.';
              break;
            case 'user-not-found':
              msg = 'Não encontramos nenhuma conta com este e-mail.';
              break;
            case 'wrong-password':
              msg = 'Senha incorreta. Verifique os dados e tente novamente.';
              break;
            case 'invalid-credential':
              msg = 'E-mail ou senha inválidos.';
              break;
            case 'too-many-requests':
              msg = 'Muitas tentativas bloqueadas. Tente novamente mais tarde.';
              break;
            case 'operation-not-allowed':
              msg = 'O login com e-mail e senha não está ativado no Firebase.';
              break;
          }
          onError(msg);
        }
      }
    }
  }
}

final resetPassCtrlProvider =
    StateNotifierProvider<ResetPasswordController, AsyncValue<void>>(
      (ref) => ResetPasswordController(),
    );
