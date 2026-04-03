import 'package:flutter/material.dart';
import 'package:petpulse_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/constants.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/models/medication.dart';
import '../providers/providers.dart';

class AddMedicationScreen extends ConsumerStatefulWidget {
  final String petId;
  final String petName;
  final Medication? existingMedication;

  const AddMedicationScreen({
    super.key,
    required this.petId,
    required this.petName,
    this.existingMedication,
  });

  @override
  ConsumerState<AddMedicationScreen> createState() =>
      _AddMedicationScreenState();
}

class _AddMedicationScreenState extends ConsumerState<AddMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dosageController;
  late TextEditingController _notesController;
  String _frequency = 'daily';
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final med = widget.existingMedication;
    _isEditing = med != null;
    _nameController = TextEditingController(text: med?.name ?? '');
    _dosageController = TextEditingController(text: med?.dosage ?? '');
    _notesController = TextEditingController(text: med?.notes ?? '');
    _frequency = med?.frequency ?? 'daily';
    _startDate = med?.startDate ?? DateTime.now();
    _endDate = med?.endDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat.yMMMd();

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? l10n.editMedication : l10n.addMedication),
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
                  labelText: l10n.medicationName,
                  prefixIcon: const Icon(Icons.medication),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.fieldRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _dosageController,
                decoration: InputDecoration(
                  labelText: l10n.dosage,
                  prefixIcon: const Icon(Icons.science_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // Frequency picker
              Text(
                l10n.selectFrequency,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: AppConstants.frequencyOptions.map((freq) {
                  final isSelected = _frequency == freq;
                  return ChoiceChip(
                    label: Text(_frequencyLabel(freq, l10n)),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() => _frequency = freq);
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppColors.textOnPrimary
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    showCheckmark: false,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Start date
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _startDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2050),
                  );
                  if (date != null) {
                    setState(() => _startDate = date);
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.startDate,
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                  child: Text(dateFormat.format(_startDate)),
                ),
              ),
              const SizedBox(height: 16),

              // End date
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _endDate ?? _startDate.add(const Duration(days: 30)),
                    firstDate: _startDate,
                    lastDate: DateTime(2050),
                  );
                  if (date != null) {
                    setState(() => _endDate = date);
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.endDate,
                    prefixIcon: const Icon(Icons.event),
                    suffixIcon: _endDate != null
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() => _endDate = null);
                            },
                          )
                        : null,
                  ),
                  child: Text(
                    _endDate != null
                        ? dateFormat.format(_endDate!)
                        : l10n.selectDate,
                    style: TextStyle(
                      color: _endDate != null
                          ? AppColors.textPrimary
                          : AppColors.textLight,
                    ),
                  ),
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
                        .read(medicationNotifierProvider(widget.petId).notifier)
                        .deleteMedication(widget.existingMedication!.id);
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

  String _frequencyLabel(String freq, AppLocalizations l10n) {
    switch (freq) {
      case 'daily':
        return l10n.daily;
      case 'weekly':
        return l10n.weekly;
      case 'monthly':
        return l10n.monthly;
      default:
        return freq;
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final medication = Medication(
      id: widget.existingMedication?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      petId: widget.petId,
      name: _nameController.text.trim(),
      dosage: _dosageController.text.trim(),
      frequency: _frequency,
      startDate: _startDate,
      endDate: _endDate,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    final notifier =
        ref.read(medicationNotifierProvider(widget.petId).notifier);
    if (_isEditing) {
      notifier.updateMedication(medication, widget.petName);
    } else {
      notifier.addMedication(medication, widget.petName);
    }

    Navigator.pop(context);
  }
}
