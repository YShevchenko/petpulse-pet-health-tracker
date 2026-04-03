import 'package:flutter/material.dart';
import 'package:petpulse_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/models/weight_entry.dart';
import '../providers/providers.dart';
import '../widgets/weight_chart.dart';

class WeightLogScreen extends ConsumerWidget {
  final String petId;
  final List<WeightEntry> entries;

  const WeightLogScreen({
    super.key,
    required this.petId,
    required this.entries,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat.yMMMd();

    // Sort entries by date descending for the list
    final sortedDesc = List<WeightEntry>.from(entries)
      ..sort((a, b) => b.date.compareTo(a.date));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chart
          if (entries.length >= 2) ...[
            Text(
              l10n.weightTrend,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            WeightChart(entries: entries),
            const SizedBox(height: 24),
          ],

          // Latest weight highlight
          if (sortedDesc.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.monitor_weight,
                        color: AppColors.secondary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.latestWeight,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '${sortedDesc.first.weightKg.toStringAsFixed(1)} ${l10n.weightUnit}',
                          style:
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      dateFormat.format(sortedDesc.first.date),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),

          // History list
          ...sortedDesc.map((entry) => Dismissible(
                key: Key(entry.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  color: AppColors.error,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) {
                  ref
                      .read(weightNotifierProvider(petId).notifier)
                      .deleteEntry(entry.id);
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.show_chart,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    '${entry.weightKg.toStringAsFixed(1)} ${l10n.weightUnit}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  subtitle: Text(dateFormat.format(entry.date)),
                  trailing: _buildTrendIcon(entry, sortedDesc),
                ),
              )),
        ],
      ),
    );
  }

  Widget? _buildTrendIcon(
      WeightEntry entry, List<WeightEntry> sortedDesc) {
    final index = sortedDesc.indexOf(entry);
    if (index >= sortedDesc.length - 1) return null;

    final previous = sortedDesc[index + 1];
    final diff = entry.weightKg - previous.weightKg;

    if (diff > 0.1) {
      return const Icon(Icons.trending_up, color: AppColors.secondary, size: 20);
    } else if (diff < -0.1) {
      return const Icon(Icons.trending_down, color: AppColors.primary, size: 20);
    }
    return const Icon(Icons.trending_flat, color: AppColors.textLight, size: 20);
  }
}
