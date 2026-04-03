import 'package:flutter/material.dart';
import 'package:petpulse_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/constants.dart';
import '../../core/theme/app_colors.dart';
import '../providers/providers.dart';
import '../widgets/pet_card.dart';
import 'add_pet_screen.dart';
import 'pet_detail_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    final isPremium = ref.read(isPremiumProvider);
    if (!isPremium) {
      _bannerAd = ref.read(adServiceProvider).loadBannerAd();
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final petsAsync = ref.watch(petNotifierProvider);
    final isPremium = ref.watch(isPremiumProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: petsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Text('Error: $error'),
              ),
              data: (pets) {
                if (pets.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pets,
                          size: 80,
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.noPets,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.tapToAdd,
                          style:
                              Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    return PetCard(
                      pet: pet,
                      onTap: () {
                        ref.read(adServiceProvider).trackScreenNavigation();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PetDetailScreen(pet: pet),
                          ),
                        );
                      },
                      onLongPress: () =>
                          _showDeleteDialog(context, pet.id, pet.name),
                    );
                  },
                );
              },
            ),
          ),
          // Banner ad for free tier
          if (!isPremium && _bannerAd != null)
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              color: AppColors.background,
              child: AdWidget(ad: _bannerAd!),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final isPrem = ref.read(isPremiumProvider);
          if (!isPrem) {
            final count =
                await ref.read(petNotifierProvider.notifier).getPetCount();
            if (count >= AppConstants.freeTierMaxPets) {
              if (context.mounted) {
                _showPremiumDialog(context);
              }
              return;
            }
          }
          if (context.mounted) {
            ref.read(adServiceProvider).trackScreenNavigation();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddPetScreen()),
            );
          }
        },
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String petId, String petName) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteConfirmTitle(petName)),
        content: Text(l10n.deleteConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              ref.read(petNotifierProvider.notifier).deletePet(petId);
              Navigator.pop(ctx);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }

  void _showPremiumDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.upgradeToPremium),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.freeTierLimit),
            const SizedBox(height: 12),
            Text(l10n.premiumDescription),
            const SizedBox(height: 8),
            Text(
              l10n.premiumPrice,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                  ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final iapService = ref.read(iapServiceProvider);
              await iapService.purchasePremium();
            },
            child: Text(l10n.upgradeToPremium),
          ),
        ],
      ),
    );
  }
}
