import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petpulse_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/constants.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/models/pet.dart';
import '../../domain/models/weight_entry.dart';
import '../providers/providers.dart';
import '../widgets/medication_card.dart';
import '../widgets/vaccination_card.dart';
import '../widgets/weight_chart.dart';
import 'add_medication_screen.dart';
import 'add_pet_screen.dart';
import 'add_vaccination_screen.dart';
import 'pet_passport_screen.dart';
import 'weight_log_screen.dart';

class PetDetailScreen extends ConsumerWidget {
  final Pet pet;

  const PetDetailScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(pet.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddPetScreen(existingPet: pet),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.description_outlined),
              tooltip: l10n.petPassport,
              onPressed: () {
                ref.read(adServiceProvider).trackScreenNavigation();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PetPassportScreen(pet: pet),
                  ),
                );
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.overview),
              Tab(text: l10n.vaccinations),
              Tab(text: l10n.medications),
              Tab(text: l10n.weight),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _OverviewTab(pet: pet),
            _VaccinationsTab(pet: pet),
            _MedicationsTab(pet: pet),
            _WeightTab(pet: pet),
          ],
        ),
      ),
    );
  }
}

class _OverviewTab extends ConsumerWidget {
  final Pet pet;
  const _OverviewTab({required this.pet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat.yMMMd();
    final vaccinationsAsync = ref.watch(vaccinationNotifierProvider(pet.id));
    final medicationsAsync = ref.watch(medicationNotifierProvider(pet.id));
    final weightAsync = ref.watch(weightNotifierProvider(pet.id));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pet info card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _buildAvatar(pet),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pet.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 4),
                        _infoRow(
                            context, l10n.species, _capitalizeFirst(pet.species)),
                        if (pet.breed.isNotEmpty)
                          _infoRow(context, l10n.breed, pet.breed),
                        if (pet.birthday != null) ...[
                          _infoRow(context, l10n.birthday,
                              dateFormat.format(pet.birthday!)),
                          _infoRow(context, l10n.age, pet.ageString),
                        ],
                        if (pet.microchipId != null &&
                            pet.microchipId!.isNotEmpty)
                          _infoRow(context, l10n.microchipId, pet.microchipId!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Quick stats
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.vaccines,
                  label: l10n.vaccinations,
                  value: vaccinationsAsync.when(
                    data: (v) => '${v.length}',
                    loading: () => '-',
                    error: (_, st) => '0',
                  ),
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.medication,
                  label: l10n.medications,
                  value: medicationsAsync.when(
                    data: (m) => '${m.where((med) => med.isActive).length}',
                    loading: () => '-',
                    error: (_, st) => '0',
                  ),
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.monitor_weight_outlined,
                  label: l10n.weight,
                  value: weightAsync.when(
                    data: (w) => w.isNotEmpty
                        ? '${w.last.weightKg.toStringAsFixed(1)} kg'
                        : '-',
                    loading: () => '-',
                    error: (_, st) => '-',
                  ),
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Dashboard summary: due medications
          medicationsAsync.when(
            data: (medications) {
              final dueMeds = medications
                  .where((m) => m.isActive && m.isDueToday)
                  .toList();
              if (dueMeds.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.dueMedications,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ...dueMeds.map((m) => Card(
                        color: AppColors.accent.withValues(alpha: 0.07),
                        child: ListTile(
                          leading: const Icon(Icons.medication,
                              color: AppColors.accent),
                          title: Text(m.name),
                          subtitle: Text(m.dosage),
                          dense: true,
                        ),
                      )),
                  const SizedBox(height: 16),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (e, _) => const SizedBox.shrink(),
          ),

          // Dashboard summary: upcoming vaccinations (expiring within 30 days)
          vaccinationsAsync.when(
            data: (vaccinations) {
              final upcoming = vaccinations
                  .where((v) =>
                      v.daysUntilExpiry != null &&
                      v.daysUntilExpiry! <= 30)
                  .toList()
                ..sort((a, b) =>
                    (a.daysUntilExpiry ?? 0).compareTo(b.daysUntilExpiry ?? 0));
              if (upcoming.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.upcomingVaccinations,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ...upcoming.map((v) {
                    final days = v.daysUntilExpiry!;
                    final color = days < 0 ? AppColors.expiryRed : AppColors.expiryYellow;
                    return Card(
                      color: color.withValues(alpha: 0.07),
                      child: ListTile(
                        leading: Icon(Icons.vaccines, color: color),
                        title: Text(v.name),
                        subtitle: Text(
                          days < 0
                              ? l10n.expiredDaysAgo(days.abs())
                              : l10n.expiresIn(days),
                        ),
                        dense: true,
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (e, _) => const SizedBox.shrink(),
          ),

          // Weight chart preview
          weightAsync.when(
            data: (entries) {
              if (entries.length < 2) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.weightTrend,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  WeightChart(entries: entries),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, st) => const SizedBox.shrink(),
          ),

          if (pet.notes != null && pet.notes!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              l10n.notes,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(pet.notes!),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar(Pet pet) {
    if (pet.photoPath != null && pet.photoPath!.isNotEmpty) {
      final file = File(pet.photoPath!);
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
          file,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          errorBuilder: (_, e, st) => _buildFallback(pet),
        ),
      );
    }
    return _buildFallback(pet);
  }

  Widget _buildFallback(Pet pet) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(Icons.pets, color: AppColors.primary, size: 40),
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          Text(value, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  String _capitalizeFirst(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _VaccinationsTab extends ConsumerWidget {
  final Pet pet;
  const _VaccinationsTab({required this.pet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final vaccinationsAsync = ref.watch(vaccinationNotifierProvider(pet.id));

    return Scaffold(
      body: vaccinationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (vaccinations) {
          if (vaccinations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.vaccines,
                    size: 64,
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 12),
                  Text(l10n.noVaccinations,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: vaccinations.length,
            itemBuilder: (context, index) {
              final vax = vaccinations[index];
              return VaccinationCard(
                vaccination: vax,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddVaccinationScreen(
                        petId: pet.id,
                        petName: pet.name,
                        existingVaccination: vax,
                      ),
                    ),
                  );
                },
                onDelete: () {
                  ref
                      .read(vaccinationNotifierProvider(pet.id).notifier)
                      .deleteVaccination(vax.id);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'add_vax',
        onPressed: () {
          ref.read(adServiceProvider).trackScreenNavigation();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddVaccinationScreen(
                petId: pet.id,
                petName: pet.name,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _MedicationsTab extends ConsumerWidget {
  final Pet pet;
  const _MedicationsTab({required this.pet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final medicationsAsync = ref.watch(medicationNotifierProvider(pet.id));

    return Scaffold(
      body: medicationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (medications) {
          if (medications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.medication,
                    size: 64,
                    color: AppColors.accent.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 12),
                  Text(l10n.noMedications,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: medications.length,
            itemBuilder: (context, index) {
              final med = medications[index];
              return MedicationCard(
                medication: med,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddMedicationScreen(
                        petId: pet.id,
                        petName: pet.name,
                        existingMedication: med,
                      ),
                    ),
                  );
                },
                onMarkGiven: () async {
                  final givenAt = DateTime.now();
                  await ref
                      .read(medicationNotifierProvider(pet.id).notifier)
                      .markAsGiven(med.id, pet.name);
                  if (context.mounted) {
                    final timeStr = DateFormat.jm().format(givenAt);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Logged at $timeStr'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                onDelete: () {
                  ref
                      .read(medicationNotifierProvider(pet.id).notifier)
                      .deleteMedication(med.id);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'add_med',
        onPressed: () async {
          final isPremium = ref.read(isPremiumProvider);
          if (!isPremium) {
            final count = await ref
                .read(medicationNotifierProvider(pet.id).notifier)
                .getMedicationCount();
            if (count >= AppConstants.freeTierMaxMedications) {
              if (context.mounted) {
                _showMedicationLimitDialog(context, ref);
              }
              return;
            }
          }
          if (context.mounted) {
            ref.read(adServiceProvider).trackScreenNavigation();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddMedicationScreen(
                  petId: pet.id,
                  petName: pet.name,
                ),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showMedicationLimitDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.upgradeToPremium),
        content: Text(l10n.freeMedicationLimit),
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

class _WeightTab extends ConsumerWidget {
  final Pet pet;
  const _WeightTab({required this.pet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final weightAsync = ref.watch(weightNotifierProvider(pet.id));

    return Scaffold(
      body: weightAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (entries) {
          if (entries.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.monitor_weight_outlined,
                    size: 64,
                    color: AppColors.secondary.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 12),
                  Text(l10n.noWeightEntries,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            );
          }

          return WeightLogScreen(petId: pet.id, entries: entries);
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'add_weight',
        onPressed: () {
          ref.read(adServiceProvider).trackScreenNavigation();
          _showAddWeightDialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddWeightDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    DateTime selectedDate = DateTime.now();
    bool useLbs = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(l10n.logWeight),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Unit toggle (lbs / kg)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    isSelected: [!useLbs, useLbs],
                    onPressed: (index) {
                      setState(() => useLbs = index == 1);
                    },
                    borderRadius: BorderRadius.circular(8),
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('kg'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('lbs'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: useLbs ? l10n.weightLbs : l10n.weightKg,
                  suffixText: useLbs ? 'lbs' : 'kg',
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: ctx,
                    initialDate: selectedDate,
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 365 * 10)),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() => selectedDate = date);
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.date,
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  child: Text(DateFormat.yMMMd().format(selectedDate)),
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
              onPressed: () {
                final rawValue = double.tryParse(controller.text);
                if (rawValue != null && rawValue > 0) {
                  // Always store in kg internally
                  final weightKg = useLbs ? rawValue * 0.453592 : rawValue;
                  final entry = WeightEntry(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    petId: pet.id,
                    date: selectedDate,
                    weightKg: weightKg,
                  );
                  ref
                      .read(weightNotifierProvider(pet.id).notifier)
                      .addEntry(entry);
                  Navigator.pop(ctx);
                }
              },
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }
}
