import 'package:equatable/equatable.dart';

class WeightEntry extends Equatable {
  final String id;
  final String petId;
  final DateTime date;
  final double weightKg;

  const WeightEntry({
    required this.id,
    required this.petId,
    required this.date,
    required this.weightKg,
  });

  WeightEntry copyWith({
    String? id,
    String? petId,
    DateTime? date,
    double? weightKg,
  }) {
    return WeightEntry(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      date: date ?? this.date,
      weightKg: weightKg ?? this.weightKg,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pet_id': petId,
      'date': date.toIso8601String(),
      'weight_kg': weightKg,
    };
  }

  factory WeightEntry.fromMap(Map<String, dynamic> map) {
    return WeightEntry(
      id: map['id'] as String,
      petId: map['pet_id'] as String,
      date: DateTime.parse(map['date'] as String),
      weightKg: (map['weight_kg'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [id, petId, date, weightKg];
}
