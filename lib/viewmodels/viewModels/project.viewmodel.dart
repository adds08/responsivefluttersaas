import 'package:flutter/foundation.dart';

enum DataFormState { create, update, hidden }

class AddProjectWidgetProvider extends ChangeNotifier {
  int updateIndex = -1;
  DataFormState state = DataFormState.hidden;

  AddProjectWidgetProvider();

  void show() {
    state = DataFormState.create;
    notifyListeners();
  }

  void showEdit(int editIndex) {
    state = DataFormState.update;
    updateIndex = editIndex;
    notifyListeners();
  }

  void hide() {
    state = DataFormState.hidden;
    updateIndex = -1;
    notifyListeners();
  }
}
