import 'package:app_flutter_riverpod/app/features/profile/domain/entities/profile.entity.dart';
import 'package:app_flutter_riverpod/app/features/profile/domain/repositories/i_profiles_repository.dart';
import 'package:dio/dio.dart';

import '../models/profile.model.dart';

class ProfilesRepositoryImpl implements IProfilesRepository {
  final Dio _dio;

  ProfilesRepositoryImpl(this._dio);

  @override
  Future<List<ProfileEntity>> getUserProfiles(String accountId) async {
    try {
      final response = await _dio.get('/profiles/list/${accountId}');
      final List<dynamic> data = response.data as List<dynamic>;

      return data
          .map((json) => ProfileModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Erro ao buscar perfis da conta: ${e.message}');
    }
  }

  @override
  Future<ProfileEntity> createProfile(
    String accountId, {
    required String name,
    required String avatarAssetPath,
    required String deviceId,
    required String deviceName,
  }) async {
    try {
      final response = await _dio.post(
        '/profiles/create/$accountId',
        data: {
          'name': name,
          'avatar_asset_path': avatarAssetPath,
          'device_id': deviceId,
          'device_name': deviceName,
        },
      );

      final Map<String, dynamic> safeJson = Map<String, dynamic>.from(
        response.data as Map,
      );
      return ProfileModel.fromJson(safeJson);
    } on DioException catch (e) {
      throw Exception('Erro ao criar novo perfil: ${e.message}');
    }
  }
}
