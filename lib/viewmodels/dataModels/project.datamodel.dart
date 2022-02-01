import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mapnpospoc/models/project.model.dart';

class ProjectProvider extends ChangeNotifier {
  late List<Project> _projects;

  ProjectProvider() {
    _projects = [];
    getProjects();
  }

  List<Project> get projects => _projects;

  void getProjects() async {
    var box = await Hive.openBox<Project>('project');
    updateAndNotify(box);
  }

  void addProject(Project newProject) async {
    var box = await Hive.openBox<Project>('project');
    box.add(newProject);
    updateAndNotify(box);
  }

  void updateProject(int index, Project newProject) async {
    var box = await Hive.openBox<Project>('project');
    box.putAt(index, newProject);
    updateAndNotify(box);
  }

  void removeProject(int index) async {
    var box = await Hive.openBox<Project>('project');
    box.deleteAt(index);
    updateAndNotify(box);
  }

  void update(box) {
    _projects = box.values.toList();
  }

  void updateAndNotify(box) {
    _projects = box.values.toList();
    notifyListeners();
  }
}
