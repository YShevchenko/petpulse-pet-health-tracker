import 'package:flutter/material.dart';
import 'package:petpulse_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/models/vaccination.dart';
import '../providers/providers.dart';

class AddVaccinationScreen extends ConsumerStatefulWidget {
  final String petId;
  final String petName;
  final Vaccination? existingVaccination;

  const AddVaccinationScreen({
    super.key,
    required this.petId,
    required this.petName,
    this.existingVaccination,
  });

  @override
  ConsumerState<AddVaccinationScreen> createState() =>
      _AddVaccinationScreenState();
}

class _AddVaccinationScreenState extends ConsumerState<AddVaccinationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _vetNameController;
  late TextEditingController _notesController;
  DateTime _dateAdministered = DateTime.now();
  DateTime? _expirationDate;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final vax = widget.existingVaccination;
    _isEditing = vax != null;
    _nameController = TextEditingController(text: vax?.name ?? '');
    _vetNameController = TextEditingController(text: vax?.vetName ?? '');
    _notesController = TextEditingController(text: vax?.notes ?? '');
    _dateAdministered = vax?.dateAdministered ?? DateTime.now();
    _expirationDate = vax?.expirationDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _vetNameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat.yMMMd();

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? l10n.editVaccination : l10n.addVaccination),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.vaccinationName,
                  prefixIcon: const Icon(Icons.vaccines),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.fieldRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Date administered
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _dateAdministered,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() => _dateAdministered = date);
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.dateAdministered,
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                  child: Text(dateFormat.format(_dateAdministered)),
                ),
              ),
              const SizedBox(height: 16),

              // Expiration date
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate:
                        _expirationDate ?? _dateAdministered.add(const Duration(days: 365)),
                    firstDate: _dateAdministered,
                    lastDate: DateTime(2050),
                  );
                  if (date != null) {
                    setState(() => _expirationDate = date);
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.expirationDate,
                    prefixIcon: const Icon(Icons.event),
                    suffixIcon: _expirationDate != null
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() => _expirationDate = null);
                            },
                          )
                        : null,
                  ),
                  child: Text(
                    _expirationDate != null
                        ? dateFormat.format(_expirationDate!)
                        : l10n.selectDate,
                    style: TextStyle(
                      color: _expirationDate != null
                          ? AppColors.textPrimary
                          : AppColors.textLight,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Vet name
              TextFormField(
                controller: _vetNameController,
                decoration: InputDecoration(
                  labelText: l10n.vetName,
                  prefixIcon: const Icon(Icons.local_hospital_outlined),
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

              ElevatedButton(
                onPressed: _save,
                child: Text(l10n.save),
              ),

              if (_isEditing) ...[
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    ref
                        .read(vaccinationNotifierProvider(widget.petId).notifier)
                        .deleteVaccination(widget.existingVaccination!.id);
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                  ),
                  child: Text(l10n.delete),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final vaccination = Vaccination(
      id: widget.existingVaccination?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      petId: widget.petId,
      name: _nameController.text.trim(),
      dateAdministered: _dateAdministered,
      expirationDate: _expirationDate,
      vetName: _vetNameController.text.trim().isEmpty
          ? null
          : _vetNameController.text.trim(),
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    final notifier =
        ref.read(vaccinationNotifierProvider(widget.petId).notifier);
    if (_isEditing) {
      notifier.updateVaccination(vaccination, widget.petName);
    } else {
      notifier.addVaccination(vaccination, widget.petName);
    }

    Navigator.pop(context);
  }
}
