import 'package:app_flutter_riverpod/app/core/utils/progress_app.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crise/components/button.component.dart';
import 'package:flutter_crise/components/input-text.component.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design_system/colors/colors.dart';
import '../../../../core/utils/navigator_app.dart';
import '../../../catalog_movies/presentation/pages/catalog_movies.page.dart';
import '../../domain/entities/profile.entity.dart';
import '../controllers/profile.provider.dart';

class ProfileSelectionPage extends ConsumerWidget {
  final String accountId;

  const ProfileSelectionPage({super.key, required this.accountId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(userProfilesProvider(accountId));

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF0C0C12),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextComponent(
                      value: 'Quem está assistindo?',
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                    const SizedBox(height: 40),
                    profilesAsync.when(
                      loading: () => const ProgressAppComponent(),
                      error: (err, stack) => TextComponent(
                        value: 'Erro ao carregar perfis: $err',
                        color: AppColor.danger,
                      ),
                      data: (profiles) {
                        return Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          alignment: WrapAlignment.center,
                          children: [
                            ...profiles.map(
                              (profile) =>
                                  _buildProfileItem(context, ref, profile),
                            ),
                            if (profiles.length < 5)
                              _buildAddProfileButton(context, ref),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonStylizedOutlineComponent(
                            padding: EdgeInsetsGeometry.all(5),
                            borderRadius: 100,
                            outlineColor: AppColor.button,
                            label: TextComponent(
                              value: 'Voltar ao menu',
                              color: Colors.white,
                            ),
                            onPressed: () {
                              NavigatorApp.to(context, CatalogMoviesPage());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context,
    WidgetRef ref,
    ProfileEntity profile,
  ) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedProfileProvider.notifier).state = profile;
        NavigatorApp.to(context, const CatalogMoviesPage());
      },
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.transparent, width: 3),
              image: DecorationImage(
                image: AssetImage(profile.avatarAssetPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextComponent(
            value: profile.name,
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildAddProfileButton(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: ButtonStylizedComponent(
            color: AppColor.button,
            padding: EdgeInsetsGeometry.all(5),
            borderRadius: 100,
            label: TextComponent(
              value: 'Gerenciar perfis',
              color: Colors.white,
            ),
            onPressed: () {
              _showCreateProfileModal(context, ref);
            },
          ),
        ),
      ],
    );
  }

  void _showCreateProfileModal(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final List<String> availableAvatars = [
      'assets/images/avatar_01.png',
      'assets/images/avatar_02.jpg',
      'assets/images/avatar_03.jpg',
      'assets/images/avatar_04.jpg',
      'assets/images/avatar_05.jpg',
    ];
    String selectedAvatar = availableAvatars.first;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF13131A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                top: 24,
                left: 24,
                right: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextComponent(
                    value: 'Criar Novo Perfil',
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(selectedAvatar),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextComponent(
                    value: 'Escolha um avatar:',
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 70,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: availableAvatars.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final avatar = availableAvatars[index];
                        final isSelected = avatar == selectedAvatar;
                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              selectedAvatar = avatar;
                            });
                          },
                          child: Container(
                            width: 70,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? AppColor.button
                                    : Colors.transparent,
                                width: 3,
                              ),
                              image: DecorationImage(
                                image: AssetImage(avatar),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  InputTextComponent(
                    textEditingController: nameCtrl,
                    labelText: 'Nome do perfil',
                    hintText: 'Informe o nome',
                    textColor: Colors.white,
                    borderColor: Colors.white,
                    borderRadius: 16,
                    onChanged: (event) {},
                    maxLength: 20,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonStylizedComponent(
                          color: AppColor.button,
                          padding: EdgeInsetsGeometry.all(5),
                          borderRadius: 100,
                          label: TextComponent(
                            value: 'Salvar perfil',
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            if (nameCtrl.text.trim().isEmpty) return;

                            await ref
                                .read(profilesRepositoryProvider)
                                .createProfile(
                                  accountId,
                                  name: nameCtrl.text.trim(),
                                  avatarAssetPath: selectedAvatar,
                                  deviceId: 'dispositivo_flutter_id',
                                  deviceName: 'Smartphone',
                                );

                            ref.invalidate(userProfilesProvider(accountId));
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
