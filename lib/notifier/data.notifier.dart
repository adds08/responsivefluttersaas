import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/models/dataModels/user.datamodel.dart';

class DataNotifier {
  // DataNotifier._();
  static final userDataNotifier = ChangeNotifierProvider.autoDispose<UserProvider>((ref) => UserProvider());
}
