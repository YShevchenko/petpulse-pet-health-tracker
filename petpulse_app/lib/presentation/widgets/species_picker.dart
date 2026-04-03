import 'package:flutter/material.dart';
import 'package:petpulse_app/l10n/app_localizations.dart';

import '../../core/constants.dart';
import '../../core/theme/app_colors.dart';

class SpeciesPicker extends StatelessWidget {
  final String? selectedSpecies;
  final ValueChanged<String> onSelected;

  const SpeciesPicker({
    super.key,
    this.selectedSpecies,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: AppConstants.speciesList.map((species) {
        final isSelected = selectedSpecies == species;
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _speciesIcon(species),
                size: 18,
                color: isSelected ? AppColors.textOnPrimary : _speciesColor(species),
              ),
              const SizedBox(width: 6),
              Text(_speciesLabel(species, l10n)),
            ],
          ),
          selected: isSelected,
          onSelected: (_) => onSelected(species),
          selectedColor: AppColors.primary,
          labelStyle: TextStyle(
            color: isSelected ? AppColors.textOnPrimary : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? AppColors.primary : AppColors.border,
            ),
          ),
          showCheckmark: false,
        );
      }).toList(),
    );
  }

  String _speciesLabel(String species, AppLocalizations l10n) {
    switch (species) {
      case 'dog':
        return l10n.dog;
      case 'cat':
        return l10n.cat;
      case 'bird':
        return l10n.bird;
      case 'rabbit':
        return l10n.rabbit;
      default:
        return l10n.other;
    }
  }

  IconData _speciesIcon(String species) {
    switch (species) {
      case 'dog':
        return Icons.pets;
      case 'cat':
        return Icons.pets;
      case 'bird':
        return Icons.flutter_dash;
      case 'rabbit':
        return Icons.cruelty_free;
      default:
        return Icons.pets;
    }
  }

  Color _speciesColor(String species) {
    switch (species) {
      case 'dog':
        return AppColors.dogColor;
      case 'cat':
        return AppColors.catColor;
      case 'bird':
        return AppColors.birdColor;
      case 'rabbit':
        return AppColors.rabbitColor;
      default:
        return AppColors.otherColor;
    }
  }
}
