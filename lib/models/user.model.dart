import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'user.model.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  late String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int age;

  @HiveField(3)
  final String gender;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String contact;

  User({
    String? id,
    required this.name,
    required this.age,
    required this.gender,
    this.email = "nouseremail@noemail.com",
    this.contact = "",
  }) {
    id = id ?? const Uuid().v1();
  }

  User copyWith({
    String? id,
    String? name,
    int? age,
    String? gender,
    String? email,
    String? contact,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      contact: contact ?? this.contact,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'email': email,
      'contact': contact,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      gender: map['gender'] ?? '',
      email: map['email'] ?? '',
      contact: map['contact'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, age: $age, gender: $gender, email: $email, contact: $contact)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.age == age &&
        other.gender == gender &&
        other.email == email &&
        other.contact == contact;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ age.hashCode ^ gender.hashCode ^ email.hashCode ^ contact.hashCode;
  }
}
