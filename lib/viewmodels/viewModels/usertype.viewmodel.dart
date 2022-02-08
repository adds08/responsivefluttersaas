import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddUserTypeWidgetProvider extends StateNotifier<bool> {
  AddUserTypeWidgetProvider() : super(false);

  void show() {
    state = true;
  }

  void hide() {
    state = false;
  }
}
