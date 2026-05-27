import 'package:app_flutter_riverpod/app/features/profile/domain/entities/profile.entity.dart';

abstract class IProfilesRepository {
  Future<List<ProfileEntity>> getUserProfiles(String accountId);
  Future<ProfileEntity> createProfile(
    String account, {
    required String name,
    required String avatarAssetPath,
    required String deviceId,
    required String deviceName,
  });
}
