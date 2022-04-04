import 'package:mapnpospoc/models/project.model.dart';

abstract class ProjectRepository {
  Future<Project> getProject();
  Future<List<Project>> getProjects();
  Future<List<void>> createProject();
  Future<void> removeProject(String id);
}

class ProjectLocalRepository implements ProjectRepository {
  @override
  Future<List<void>> createProject() {
    // TODO: implement createProject
    throw UnimplementedError();
  }

  @override
  Future<Project> getProject() {
    // TODO: implement getProject
    throw UnimplementedError();
  }

  @override
  Future<List<Project>> getProjects() {
    // TODO: implement getProjects
    throw UnimplementedError();
  }

  @override
  Future<void> removeProject(String id) {
    // TODO: implement removeProject
    throw UnimplementedError();
  }
}
