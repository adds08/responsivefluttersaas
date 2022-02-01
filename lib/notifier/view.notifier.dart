import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/viewmodels/viewModels/project.viewmodel.dart';
import 'package:mapnpospoc/viewmodels/viewModels/user.viewmodel.dart';

class ViewNotifier {
  ViewNotifier._();
  static final adduserWidgetNotifier = StateNotifierProvider.autoDispose<AddUserWidgetProvider, bool>((ref) => AddUserWidgetProvider());
  static final addprojectWidgetNotifier = ChangeNotifierProvider.autoDispose<AddProjectWidgetProvider>((ref) => AddProjectWidgetProvider());
}
