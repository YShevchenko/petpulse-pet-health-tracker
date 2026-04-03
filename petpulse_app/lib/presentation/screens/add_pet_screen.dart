import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petpulse_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../core/theme/app_colors.dart';
import '../../domain/models/pet.dart';
import '../providers/providers.dart';
import '../widgets/species_picker.dart';

class AddPetScreen extends ConsumerStatefulWidget {
  final Pet? existingPet;

  const AddPetScreen({super.key, this.existingPet});

  @override
  ConsumerState<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends ConsumerState<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _breedController;
  late TextEditingController _notesController;
  late TextEditingController _microchipController;
  String _selectedSpecies = 'dog';
  DateTime? _birthday;
  String? _photoPath;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final pet = widget.existingPet;
    _isEditing = pet != null;
    _nameController = TextEditingController(text: pet?.name ?? '');
    _breedController = TextEditingController(text: pet?.breed ?? '');
    _notesController = TextEditingController(text: pet?.notes ?? '');
    _microchipController = TextEditingController(text: pet?.microchipId ?? '');
    _selectedSpecies = pet?.species ?? 'dog';
    _birthday = pet?.birthday;
    _photoPath = pet?.photoPath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _notesController.dispose();
    _microchipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? l10n.editPet : l10n.addPet),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Photo
              Center(
                child: GestureDetector(
                  onTap: _pickPhoto,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 56,
                        backgroundColor:
                            AppColors.primary.withValues(alpha: 0.1),
                        backgroundImage: _photoPath != null
                            ? FileImage(File(_photoPath!))
                            : null,
                        child: _photoPath == null
                            ? const Icon(Icons.camera_alt,
                                size: 32, color: AppColors.primary)
                            : null,
                      ),
                      if (_photoPath != null)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _photoPath = null);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close,
                                  size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.petName,
                  prefixIcon: const Icon(Icons.pets),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.fieldRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Species
              Text(
                l10n.selectSpecies,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              SpeciesPicker(
                selectedSpecies: _selectedSpecies,
                onSelected: (species) {
                  setState(() => _selectedSpecies = species);
                },
              ),
              const SizedBox(height: 16),

              // Breed
              TextFormField(
                controller: _breedController,
                decoration: InputDecoration(
                  labelText: l10n.breed,
                  prefixIcon: const Icon(Icons.category_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // Birthday
              InkWell(
                onTap: () => _pickBirthday(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.birthday,
                    prefixIcon: const Icon(Icons.cake_outlined),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _birthday != null
                        ? DateFormat.yMMMd().format(_birthday!)
                        : l10n.selectDate,
                    style: TextStyle(
                      color: _birthday != null
                          ? AppColors.textPrimary
                          : AppColors.textLight,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Microchip ID
              TextFormField(
                controller: _microchipController,
                decoration: InputDecoration(
                  labelText: l10n.microchipId,
                  prefixIcon: const Icon(Icons.qr_code_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // Notes
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: l10n.notes,
                  prefixIcon: const Icon(Icons.note_outlined),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 32),

              // Save button
              ElevatedButton(
                onPressed: _save,
                child: Text(l10n.save),
              ),

              if (_isEditing) ...[
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: _delete,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                  ),
                  child: Text(l10n.deletePet),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickPhoto() async {
    final l10n = AppLocalizations.of(context)!;

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(l10n.choosePhoto),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(l10n.takePhoto),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (picked != null) {
      // Copy to app documents directory
      final appDir = await getApplicationDocumentsDirectory();
      final photosDir = Directory(p.join(appDir.path, 'pet_photos'));
      if (!await photosDir.exists()) {
        await photosDir.create(recursive: true);
      }
      final fileName =
          'pet_${DateTime.now().millisecondsSinceEpoch}${p.extension(picked.path)}';
      final savedFile = await File(picked.path).copy(
        p.join(photosDir.path, fileName),
      );
      setState(() => _photoPath = savedFile.path);
    }
  }

  Future<void> _pickBirthday(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _birthday ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() => _birthday = date);
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now();
    final pet = Pet(
      id: widget.existingPet?.id ??
          now.millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      species: _selectedSpecies,
      breed: _breedController.text.trim(),
      birthday: _birthday,
      photoPath: _photoPath,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      microchipId: _microchipController.text.trim().isEmpty
          ? null
          : _microchipController.text.trim(),
      createdAt: widget.existingPet?.createdAt ?? now,
    );

    if (_isEditing) {
      ref.read(petNotifierProvider.notifier).updatePet(pet);
    } else {
      ref.read(petNotifierProvider.notifier).addPet(pet);
    }

    Navigator.pop(context);
  }

  void _delete() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteConfirmTitle(widget.existingPet!.name)),
        content: Text(l10n.deleteConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(petNotifierProvider.notifier)
                  .deletePet(widget.existingPet!.id);
              Navigator.pop(ctx);
              Navigator.pop(context);
              Navigator.pop(context); // Pop detail screen too
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}
