import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/network/api_client.dart';
import '../../data/repositories/profiles_repository.impl.dart';
import '../../domain/entities/profile.entity.dart';

final profilesRepositoryProvider = Provider((ref) {
  final dio = ref.watch(apiClientProvider);
  return ProfilesRepositoryImpl(dio);
});

final selectedProfileProvider = StateProvider<ProfileEntity?>((ref) => null);
final createProfileLoadingProvider = StateProvider<bool>((ref) => false);

final userProfilesProvider = FutureProvider.family<List<ProfileEntity>, String>(
  (ref, accountId) async {
    final repository = ref.watch(profilesRepositoryProvider);
    return await repository.getUserProfiles(accountId);
  },
);