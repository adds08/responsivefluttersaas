import 'dart:convert';

import 'package:hive/hive.dart';

part 'usertype.model.g.dart';

@HiveType(typeId: 0)
class UserType {
  @HiveField(0, defaultValue: 0)
  int typeId;
  @HiveField(1)
  String name;
  @HiveField(2)
  int priority;
  UserType({
    this.typeId = 0,
    required this.name,
    required this.priority,
  });

  UserType copyWith({
    int? typeId,
    String? name,
    int? priority,
  }) {
    return UserType(
      typeId: typeId ?? this.typeId,
      name: name ?? this.name,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'typeId': typeId,
      'name': name,
      'priority': priority,
    };
  }

  factory UserType.fromMap(Map<String, dynamic> map) {
    return UserType(
      typeId: map['typeId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      priority: map['priority']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserType.fromJson(String source) => UserType.fromMap(json.decode(source));

  @override
  String toString() => 'UserType(typeId: $typeId, name: $name, priority: $priority)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserType && other.typeId == typeId && other.name == name && other.priority == priority;
  }

  @override
  int get hashCode => typeId.hashCode ^ name.hashCode ^ priority.hashCode;
}
