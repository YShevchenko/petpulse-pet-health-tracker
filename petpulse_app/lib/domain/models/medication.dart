import 'package:equatable/equatable.dart';

class Medication extends Equatable {
  final String id;
  final String petId;
  final String name;
  final String dosage;
  final String frequency; // 'daily', 'weekly', 'monthly'
  final DateTime startDate;
  final DateTime? endDate;
  final String? notes;
  final DateTime? lastGiven;

  const Medication({
    required this.id,
    required this.petId,
    required this.name,
    this.dosage = '',
    this.frequency = 'daily',
    required this.startDate,
    this.endDate,
    this.notes,
    this.lastGiven,
  });

  Medication copyWith({
    String? id,
    String? petId,
    String? name,
    String? dosage,
    String? frequency,
    DateTime? startDate,
    DateTime? endDate,
    String? notes,
    DateTime? lastGiven,
  }) {
    return Medication(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      notes: notes ?? this.notes,
      lastGiven: lastGiven ?? this.lastGiven,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pet_id': petId,
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'notes': notes,
      'last_given': lastGiven?.toIso8601String(),
    };
  }

  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      id: map['id'] as String,
      petId: map['pet_id'] as String,
      name: map['name'] as String,
      dosage: (map['dosage'] as String?) ?? '',
      frequency: (map['frequency'] as String?) ?? 'daily',
      startDate: DateTime.parse(map['start_date'] as String),
      endDate: map['end_date'] != null
          ? DateTime.parse(map['end_date'] as String)
          : null,
      notes: map['notes'] as String?,
      lastGiven: map['last_given'] != null
          ? DateTime.parse(map['last_given'] as String)
          : null,
    );
  }

  /// Whether this medication is currently active (no end date or end date in future).
  bool get isActive {
    if (endDate == null) return true;
    return endDate!.isAfter(DateTime.now());
  }

  /// Calculate the next due date/time based on frequency and start date.
  DateTime get nextDue {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (frequency) {
      case 'daily':
        // Next occurrence is today if not past, otherwise tomorrow
        final todayDue =
            DateTime(now.year, now.month, now.day, 9, 0); // default 9 AM
        if (todayDue.isAfter(now)) return todayDue;
        return todayDue.add(const Duration(days: 1));

      case 'weekly':
        // Same weekday as start date
        final startWeekday = startDate.weekday;
        var nextDate = today;
        while (nextDate.weekday != startWeekday || nextDate.isBefore(today)) {
          nextDate = nextDate.add(const Duration(days: 1));
        }
        return DateTime(nextDate.year, nextDate.month, nextDate.day, 9, 0);

      case 'monthly':
        // Same day of month as start date
        final targetDay = startDate.day;
        var nextDate = DateTime(now.year, now.month, targetDay, 9, 0);
        if (nextDate.isBefore(now)) {
          nextDate = DateTime(now.year, now.month + 1, targetDay, 9, 0);
        }
        return nextDate;

      default:
        return today.add(const Duration(days: 1));
    }
  }

  bool get isDueToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = nextDue;
    final dueDate = DateTime(due.year, due.month, due.day);
    return dueDate == today;
  }

  @override
  List<Object?> get props =>
      [id, petId, name, dosage, frequency, startDate, endDate, notes, lastGiven];
}
