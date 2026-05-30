import '../entities/profile.entity.dart';

abstract class IProfilesRepository {
  Future<List<ProfileEntity>> getUserProfiles(String accountId);
  Future<ProfileEntity> createProfile(
    String accountId, {
    required String name,
    required String avatarAssetPath,
    required String deviceId,
    required String deviceName,
  });
  Future<void> deleteUserProfiles(String profileId); // Mantido void
}