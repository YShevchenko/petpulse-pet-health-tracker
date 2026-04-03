import 'package:flutter/material.dart';
import 'package:petpulse_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import '../../core/theme/app_colors.dart';
import '../providers/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isPremium = ref.watch(isPremiumProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: [
          const SizedBox(height: 8),

          // Premium section
          if (!isPremium) ...[
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppColors.primary.withValues(alpha: 0.05),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.workspace_premium,
                      size: 48,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.upgradeToPremium,
                      style:
                          Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.primary,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.premiumDescription,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        final iapService = ref.read(iapServiceProvider);
                        final success = await iapService.purchasePremium();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(success
                                  ? l10n.purchaseSuccess
                                  : l10n.purchaseError),
                            ),
                          );
                        }
                      },
                      child: Text(l10n.premiumPrice),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () async {
                        final iapService = ref.read(iapServiceProvider);
                        await iapService.restorePurchases();
                      },
                      child: Text(l10n.restorePurchases),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            ListTile(
              leading: const Icon(Icons.workspace_premium,
                  color: AppColors.secondary),
              title: Text(l10n.premium),
              subtitle: const Text('Active'),
              trailing: const Icon(Icons.check_circle, color: AppColors.accent),
            ),
          ],

          const Divider(height: 32),

          // About section
          ListTile(
            leading: const Icon(Icons.info_outline, color: AppColors.primary),
            title: Text(l10n.aboutApp),
            subtitle: Text(l10n.aboutDescription),
          ),
          ListTile(
            leading: const Icon(Icons.numbers, color: AppColors.primary),
            title: Text(l10n.version),
            subtitle: const Text(AppConstants.appVersion),
          ),
          ListTile(
            leading:
                const Icon(Icons.business, color: AppColors.primary),
            title: Text(l10n.publisher),
            subtitle: const Text(AppConstants.publisher),
          ),
          ListTile(
            leading: const Icon(Icons.email_outlined, color: AppColors.primary),
            title: const Text('Contact'),
            subtitle: const Text(AppConstants.contactEmail),
          ),
        ],
      ),
    );
  }
}
