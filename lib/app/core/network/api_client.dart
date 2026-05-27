import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.0.2:8000/api/v1',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        //final token = await FirebaseAuth.instance.currentUser?.getIdToken();
        //if (token != null) {
        //  options.headers['Authorization'] = 'Bearer $token';
        //}
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        print('[ERRO] [${e.requestOptions.method}] ${e.requestOptions.path}');
        return handler.next(e);
      },
    ),
  );

  return dio;
});