import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'project.model.g.dart';

@HiveType(typeId: 1)
class Project {
  @HiveField(0)
  String projectId = "";

  @HiveField(1)
  String projectName;

  @HiveField(2, defaultValue: 0)
  int projectCode;

  @HiveField(3)
  String projectDescription;

  @HiveField(4)
  String? projectStartdate;

  @HiveField(5)
  String? projectEnddate;

  @HiveField(6, defaultValue: 1)
  int status;

  @HiveField(7, defaultValue: "")
  String clientId;

  @HiveField(8, defaultValue: "")
  String leadId;

  @HiveField(9, defaultValue: [])
  List<String> taskId;

  Project({
    String? projectId,
    String? projectStartdate,
    String? projectEnddate,
    required this.projectName,
    required this.projectCode,
    required this.projectDescription,
    this.status = 1,
    this.clientId = "",
    this.leadId = "",
    this.taskId = const [],
  }) {
    this.projectId = projectId ?? const Uuid().v1();
    this.projectStartdate = projectStartdate ?? DateTime.now().toString().split(" ")[0];
    this.projectEnddate = projectEnddate ?? DateTime.now().add(const Duration(hours: 168)).toString().split(" ")[0];
  }

  Project copyWith({
    String? projectId,
    String? projectName,
    int? projectCode,
    String? projectDescription,
    String? projectStartdate,
    String? projectEnddate,
    int? status,
    String? clientId,
    String? leadId,
    List<String>? taskId,
  }) {
    return Project(
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      projectCode: projectCode ?? this.projectCode,
      projectDescription: projectDescription ?? this.projectDescription,
      projectStartdate: projectStartdate ?? this.projectStartdate,
      projectEnddate: projectEnddate ?? this.projectEnddate,
      status: status ?? this.status,
      clientId: clientId ?? this.clientId,
      leadId: leadId ?? this.leadId,
      taskId: taskId ?? this.taskId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'projectId': projectId,
      'projectName': projectName,
      'projectCode': projectCode,
      'projectDescription': projectDescription,
      'projectStartdate': projectStartdate,
      'projectEnddate': projectEnddate,
      'status': status,
      'clientId': clientId,
      'leadId': leadId,
      'taskId': taskId,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      projectId: map['projectId'] ?? '',
      projectName: map['projectName'] ?? '',
      projectCode: map['projectCode']?.toInt() ?? 0,
      projectDescription: map['projectDescription'] ?? '',
      projectStartdate: map['projectStartdate'],
      projectEnddate: map['projectEnddate'],
      status: map['status']?.toInt() ?? 0,
      clientId: map['clientId'] ?? '',
      leadId: map['leadId'] ?? '',
      taskId: List<String>.from(map['taskId']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) => Project.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Project(projectId: $projectId, projectName: $projectName, projectCode: $projectCode, projectDescription: $projectDescription, projectStartdate: $projectStartdate, projectEnddate: $projectEnddate, status: $status, clientId: $clientId, leadId: $leadId, taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Project &&
        other.projectId == projectId &&
        other.projectName == projectName &&
        other.projectCode == projectCode &&
        other.projectDescription == projectDescription &&
        other.projectStartdate == projectStartdate &&
        other.projectEnddate == projectEnddate &&
        other.status == status &&
        other.clientId == clientId &&
        other.leadId == leadId &&
        listEquals(other.taskId, taskId);
  }

  @override
  int get hashCode {
    return projectId.hashCode ^
        projectName.hashCode ^
        projectCode.hashCode ^
        projectDescription.hashCode ^
        projectStartdate.hashCode ^
        projectEnddate.hashCode ^
        status.hashCode ^
        clientId.hashCode ^
        leadId.hashCode ^
        taskId.hashCode;
  }
}
