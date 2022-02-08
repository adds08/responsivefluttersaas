import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/viewmodels/dataModels/user.datamodel.dart';
import 'package:mapnpospoc/viewmodels/dataModels/usertype.datamodel.dart';
import 'package:mapnpospoc/viewmodels/dataModels/project.datamodel.dart';

class DataNotifier {
  DataNotifier._();
  static final userDataNotifier = ChangeNotifierProvider<UserProvider>((ref) => UserProvider());
  static final usertypeDataNotifier = ChangeNotifierProvider<UserTypeProvider>((ref) => UserTypeProvider());
  static final projectDataNotifier = ChangeNotifierProvider<ProjectProvider>((ref) => ProjectProvider());
}
