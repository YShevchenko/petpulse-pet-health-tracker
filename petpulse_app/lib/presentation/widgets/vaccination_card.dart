import 'package:flutter/material.dart';
import 'package:petpulse_app/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/models/vaccination.dart';
import 'expiry_badge.dart';

class VaccinationCard extends StatelessWidget {
  final Vaccination vaccination;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const VaccinationCard({
    super.key,
    required this.vaccination,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat.yMMMd();

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.vaccines,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vaccination.name,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: AppColors.textPrimary,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${l10n.dateAdministered}: ${dateFormat.format(vaccination.dateAdministered)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  ExpiryBadge(
                    daysUntilExpiry: vaccination.daysUntilExpiry,
                  ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: AppColors.error, size: 20),
                      onPressed: onDelete,
                      tooltip: l10n.delete,
                    ),
                ],
              ),
              if (vaccination.expirationDate != null) ...[
                const SizedBox(height: 8),
                Text(
                  '${l10n.expirationDate}: ${dateFormat.format(vaccination.expirationDate!)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              if (vaccination.vetName != null &&
                  vaccination.vetName!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  '${l10n.vetName}: ${vaccination.vetName}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              if (vaccination.notes != null &&
                  vaccination.notes!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  vaccination.notes!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
