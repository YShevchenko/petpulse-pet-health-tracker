import 'package:flutter/material.dart';
import 'package:petpulse_app/l10n/app_localizations.dart';

import '../../core/theme/app_colors.dart';

/// Badge showing expiry status:
///   Green  : valid (>30 days away)
///   Yellow : expiring soon (≤30 days)
///   Red    : expired (<today)
///   Grey   : no expiry date set
class ExpiryBadge extends StatelessWidget {
  /// Pass null to show the grey "no expiry" badge.
  final int? daysUntilExpiry;

  const ExpiryBadge({
    super.key,
    required this.daysUntilExpiry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final Color bgColor;
    final Color textColor;
    final String label;

    if (daysUntilExpiry == null) {
      // No expiry date set → Grey
      bgColor = AppColors.textLight.withValues(alpha: 0.25);
      textColor = AppColors.textSecondary;
      label = '—';
    } else if (daysUntilExpiry! < 0) {
      // Already expired → Red
      bgColor = AppColors.expiryRed.withValues(alpha: 0.15);
      textColor = AppColors.expiryRed;
      label = l10n.expiredDaysAgo(daysUntilExpiry!.abs());
    } else if (daysUntilExpiry! == 0) {
      // Expires today → Red
      bgColor = AppColors.expiryRed.withValues(alpha: 0.15);
      textColor = AppColors.expiryRed;
      label = l10n.dueToday;
    } else if (daysUntilExpiry! <= 30) {
      // Expiring within 30 days → Yellow/Amber
      bgColor = AppColors.expiryYellow.withValues(alpha: 0.15);
      textColor = AppColors.expiryYellow;
      label = l10n.expiresIn(daysUntilExpiry!);
    } else {
      // More than 30 days → Green
      bgColor = AppColors.expiryGreen.withValues(alpha: 0.15);
      textColor = AppColors.expiryGreen;
      label = l10n.expiresIn(daysUntilExpiry!);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  /// Static utility: get the color for a given days-until-expiry value.
  /// Null = grey, ≤0 = red, ≤30 = yellow, >30 = green.
  static Color colorForDays(int? days) {
    if (days == null) return AppColors.textLight;
    if (days <= 0) return AppColors.expiryRed;
    if (days <= 30) return AppColors.expiryYellow;
    return AppColors.expiryGreen;
  }

  /// Static utility: get the status string.
  static String statusForDays(int? days) {
    if (days == null) return 'grey';
    if (days <= 0) return 'red';
    if (days <= 30) return 'yellow';
    return 'green';
  }
}
