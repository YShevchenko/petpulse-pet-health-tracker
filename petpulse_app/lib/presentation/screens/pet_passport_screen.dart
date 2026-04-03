import 'package:flutter/material.dart';
import 'package:petpulse_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/models/pet.dart';
import '../../domain/services/pdf_service.dart';
import '../providers/providers.dart';

class PetPassportScreen extends ConsumerWidget {
  final Pet pet;

  const PetPassportScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isPremium = ref.watch(isPremiumProvider);

    if (!isPremium) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.petPassport)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 64,
                  color: AppColors.primary.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.premiumFeature,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.premiumDescription,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    final iapService = ref.read(iapServiceProvider);
                    await iapService.purchasePremium();
                  },
                  child: Text('${l10n.upgradeToPremium} - ${l10n.premiumPrice}'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final vaccinationsAsync = ref.watch(vaccinationNotifierProvider(pet.id));
    final medicationsAsync = ref.watch(medicationNotifierProvider(pet.id));
    final weightAsync = ref.watch(weightNotifierProvider(pet.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.petPassport),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: l10n.sharePassport,
            onPressed: () async {
              final vaccinations = vaccinationsAsync.value ?? [];
              final medications = medicationsAsync.value ?? [];
              final latestWeight = weightAsync.value?.isNotEmpty == true
                  ? weightAsync.value!.last
                  : null;

              final pdfBytes = await PdfService.instance.generatePetPassport(
                pet: pet,
                vaccinations: vaccinations,
                medications:
                    medications.where((m) => m.isActive).toList(),
                latestWeight: latestWeight,
              );

              await Printing.sharePdf(
                bytes: pdfBytes,
                filename: '${pet.name}_passport.pdf',
              );
            },
          ),
        ],
      ),
      body: vaccinationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (vaccinations) {
          final medications = medicationsAsync.value ?? [];
          final latestWeight = weightAsync.value?.isNotEmpty == true
              ? weightAsync.value!.last
              : null;

          return PdfPreview(
            build: (format) => PdfService.instance.generatePetPassport(
              pet: pet,
              vaccinations: vaccinations,
              medications:
                  medications.where((m) => m.isActive).toList(),
              latestWeight: latestWeight,
            ),
            canChangePageFormat: false,
            canChangeOrientation: false,
            canDebug: false,
            pdfFileName: '${pet.name}_passport.pdf',
          );
        },
      ),
    );
  }
}
