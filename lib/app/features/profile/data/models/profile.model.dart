
import '../../domain/entities/profile.entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    required super.accountId,
    required super.name,
    required super.avatarAssetPath,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? '',
      accountId: json['account_id'] ?? '',
      name: json['name'] ?? '',
      avatarAssetPath: json['avatar_asset_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_id': accountId,
      'name': name,
      'avatar_asset_path': avatarAssetPath,
    };
  }
}