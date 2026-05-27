import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class RegisterController extends StateNotifier<AsyncValue> {
  RegisterController() : super(const AsyncValue.data(null));
  FirebaseAuth auth = FirebaseAuth.instance;

  FutureOr<AsyncValue> build() {
    throw UnimplementedError();
  }

  Future<void> createUser({
    required String email,
    required String password,
    required Function(String error) onError,
    required Function(UserCredential userCredential) onSuccess,
  }) async {
    final e = email.trim();
    final p = password.trim();

    if (e.isEmpty && p.isEmpty) {
      onError('Insira seu e-mail e senha!');
    } else {
      state = const AsyncLoading();

      state = await AsyncValue.guard(() async {
        final userCredential = await auth.createUserWithEmailAndPassword(
          email: e,
          password: p,
        );
        onSuccess(userCredential);
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

final registerCtrlProvider =
    StateNotifierProvider<RegisterController, AsyncValue<void>>(
      (ref) => RegisterController(),
    );
