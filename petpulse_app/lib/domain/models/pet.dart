import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  final String id;
  final String name;
  final String species;
  final String breed;
  final DateTime? birthday;
  final String? photoPath;
  final String? notes;
  final String? microchipId;
  final DateTime createdAt;

  const Pet({
    required this.id,
    required this.name,
    required this.species,
    this.breed = '',
    this.birthday,
    this.photoPath,
    this.notes,
    this.microchipId,
    required this.createdAt,
  });

  Pet copyWith({
    String? id,
    String? name,
    String? species,
    String? breed,
    DateTime? birthday,
    String? photoPath,
    String? notes,
    String? microchipId,
    DateTime? createdAt,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      breed: breed ?? this.breed,
      birthday: birthday ?? this.birthday,
      photoPath: photoPath ?? this.photoPath,
      notes: notes ?? this.notes,
      microchipId: microchipId ?? this.microchipId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'breed': breed,
      'birthday': birthday?.toIso8601String(),
      'photo_path': photoPath,
      'notes': notes,
      'microchip_id': microchipId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id'] as String,
      name: map['name'] as String,
      species: map['species'] as String,
      breed: (map['breed'] as String?) ?? '',
      birthday: map['birthday'] != null
          ? DateTime.parse(map['birthday'] as String)
          : null,
      photoPath: map['photo_path'] as String?,
      notes: map['notes'] as String?,
      microchipId: map['microchip_id'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  /// Returns the age as a human-readable string.
  String get ageString {
    if (birthday == null) return '';
    final now = DateTime.now();
    final diff = now.difference(birthday!);
    final years = diff.inDays ~/ 365;
    final months = (diff.inDays % 365) ~/ 30;
    if (years > 0) {
      return '$years yr${years > 1 ? 's' : ''}${months > 0 ? ' $months mo' : ''}';
    }
    return '$months mo';
  }

  @override
  List<Object?> get props =>
      [id, name, species, breed, birthday, photoPath, notes, microchipId, createdAt];
}
