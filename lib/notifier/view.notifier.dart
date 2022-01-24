import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/models/viewModels/user.viewmodel.dart';

class ViewNotifier {
  // ViewNotifier._();
  static final adduserWidgetNotifier = StateNotifierProvider.autoDispose<AddUserWidgetProvider, bool>((ref) => AddUserWidgetProvider());
}
