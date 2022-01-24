import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mapnpospoc/models/users.model.dart';

class UserProvider extends ChangeNotifier {
  late List<User> _users;

  UserProvider() {
    _users = [];
  }

  get users => _users;

  void getUsers() async {
    var box = await Hive.openBox<User>('user');
    _users = box.values.toList();
    notifyListeners();
  }

  void addUsers(User newUser) async {
    var box = await Hive.openBox<User>('user');
    box.add(newUser);
    notifyListeners();
  }

  void removeUsers(int index) async {
    var box = await Hive.openBox<User>('user');
    box.deleteAt(index);
    notifyListeners();
  }
}
// class UserProvider extends StateNotifier<List<User>> {
//   UserProvider() : super([]);

//   void addUsers(User newUser) {
//     state = [...state, newUser];
//   }

//   void removeUsers(User user) {
//     state.remove(user);
//   }
// }
