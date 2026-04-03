import 'package:equatable/equatable.dart';

class Vaccination extends Equatable {
  final String id;
  final String petId;
  final String name;
  final DateTime dateAdministered;
  final DateTime? expirationDate;
  final String? vetName;
  final String? notes;

  const Vaccination({
    required this.id,
    required this.petId,
    required this.name,
    required this.dateAdministered,
    this.expirationDate,
    this.vetName,
    this.notes,
  });

  Vaccination copyWith({
    String? id,
    String? petId,
    String? name,
    DateTime? dateAdministered,
    DateTime? expirationDate,
    String? vetName,
    String? notes,
  }) {
    return Vaccination(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      name: name ?? this.name,
      dateAdministered: dateAdministered ?? this.dateAdministered,
      expirationDate: expirationDate ?? this.expirationDate,
      vetName: vetName ?? this.vetName,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pet_id': petId,
      'name': name,
      'date_administered': dateAdministered.toIso8601String(),
      'expiration_date': expirationDate?.toIso8601String(),
      'vet_name': vetName,
      'notes': notes,
    };
  }

  factory Vaccination.fromMap(Map<String, dynamic> map) {
    return Vaccination(
      id: map['id'] as String,
      petId: map['pet_id'] as String,
      name: map['name'] as String,
      dateAdministered:
          DateTime.parse(map['date_administered'] as String),
      expirationDate: map['expiration_date'] != null
          ? DateTime.parse(map['expiration_date'] as String)
          : null,
      vetName: map['vet_name'] as String?,
      notes: map['notes'] as String?,
    );
  }

  /// Days until expiration. Negative = expired.
  int? get daysUntilExpiry {
    if (expirationDate == null) return null;
    return expirationDate!.difference(DateTime.now()).inDays;
  }

  /// Expiry status: 'green' (>30d), 'yellow' (1-30d), 'red' (expired/today).
  String get expiryStatus {
    final days = daysUntilExpiry;
    if (days == null) return 'green';
    if (days > 30) return 'green';
    if (days > 0) return 'yellow';
    return 'red';
  }

  bool get isExpired {
    final days = daysUntilExpiry;
    if (days == null) return false;
    return days < 0;
  }

  @override
  List<Object?> get props =>
      [id, petId, name, dateAdministered, expirationDate, vetName, notes];
}
