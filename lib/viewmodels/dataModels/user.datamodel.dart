import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mapnpospoc/models/user.model.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  List<User> get users => _users;

  UserProvider() {
    getUsers();
  }

  Future<void> getUsers() async {
    var box = await Hive.openBox<User>('user');
    _users = box.values.toList();
    notifyListeners();
  }

  void addUser(User newUser) async {
    var box = await Hive.openBox<User>('user');
    box.add(newUser);
    await getUsers();
  }

  void removeUser(int index) async {
    var box = await Hive.openBox<User>('user');
    box.deleteAt(index);
    await getUsers();
  }
}
