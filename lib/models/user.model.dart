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
    required this.name,
    required this.age,
    required this.gender,
    this.email = "nouseremail@noemail.com",
    this.contact = "",
  }) {
    id = const Uuid().v1();
  }
}
