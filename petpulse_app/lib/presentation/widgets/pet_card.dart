import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/models/pet.dart';

class PetCard extends StatelessWidget {
  final Pet pet;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const PetCard({
    super.key,
    required this.pet,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildAvatar(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          _speciesIcon(pet.species),
                          size: 16,
                          color: _speciesColor(pet.species),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _capitalizeFirst(pet.species),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        if (pet.breed.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Text(
                            pet.breed,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),
                    if (pet.birthday != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        pet.ageString,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textLight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (pet.photoPath != null && pet.photoPath!.isNotEmpty) {
      final file = File(pet.photoPath!);
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          file,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (_, e, st) => _buildFallbackAvatar(),
        ),
      );
    }
    return _buildFallbackAvatar();
  }

  Widget _buildFallbackAvatar() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: _speciesColor(pet.species).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        _speciesIcon(pet.species),
        color: _speciesColor(pet.species),
        size: 28,
      ),
    );
  }

  static IconData _speciesIcon(String species) {
    switch (species.toLowerCase()) {
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

  static Color _speciesColor(String species) {
    switch (species.toLowerCase()) {
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

  String _capitalizeFirst(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
