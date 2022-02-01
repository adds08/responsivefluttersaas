import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'project.model.g.dart';

@HiveType(typeId: 1)
class Project {
  @HiveField(0)
  late String id;

  @HiveField(1)
  final String name;

  @HiveField(2, defaultValue: 0)
  final int code;

  @HiveField(3)
  final String description;

  @HiveField(4)
  late String startdate;

  @HiveField(5)
  late String enddate;

  @HiveField(6, defaultValue: 1)
  late int status;

  Project({
    String? uuid,
    required this.name,
    this.code = 0,
    required this.description,
    String? sdate,
    String? edate,
  }) {
    id = uuid ?? const Uuid().v1();
    status = 1;
    startdate = sdate ?? DateTime.now().toString().split(" ")[0];
    enddate = edate ?? DateTime.now().add(const Duration(hours: 168)).toString().split(" ")[0];
  }
}
