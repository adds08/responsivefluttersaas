import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddUserWidgetProvider extends StateNotifier<bool> {
  AddUserWidgetProvider() : super(false);

  void show() {
    state = true;
  }

  void hide() {
    state = false;
  }
}
