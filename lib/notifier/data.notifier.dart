import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/viewmodels/dataModels/user.datamodel.dart';
import 'package:mapnpospoc/viewmodels/dataModels/project.datamodel.dart';

class DataNotifier {
  DataNotifier._();
  static final userDataNotifier = ChangeNotifierProvider.autoDispose<UserProvider>((ref) => UserProvider());
  static final projectDataNotifier = ChangeNotifierProvider.autoDispose<ProjectProvider>((ref) => ProjectProvider());
}
