import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mapnpospoc/models/usertype.model.dart';
import 'package:http/http.dart' as http;

// class RemoteHttpHelpers {
//   reauth() {}
//   requestSuccess() {}
//   requestFailed() {}
//   checkRequest(http.Response response) {}
// }

enum FutureState { init, loading, loaded, error }

class RemoteRepo {
  Future<List<UserType>> list() async {
    http.Response response = await http.get(Uri.parse('http://localhost:8000/usertype/list'));
    if (response.statusCode == 200) {
      var resdata = jsonDecode(response.body);
      if (resdata["response"] == "success") {
        var list = resdata["data"];
        List<UserType> temp = [];
        for (int i = 0; i < list.length; i++) {
          UserType userType = UserType.fromMap(list[i]);
          temp.add(userType);
        }
        return temp;
      }
    }
    return [];
  }

  Future<bool> create(Object postbody) async {
    http.Response response = await http.post(Uri.parse('http://localhost:8000/usertype/create'),
        body: jsonEncode(postbody), headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
      var resdata = jsonDecode(response.body);
      if (resdata["response"] == "success") {
        return true;
      }
    }
    return false;
  }

  Future<bool> delete(int id) async {
    http.Response response = await http.delete(Uri.parse("http://localhost:8000/usertype/delete/$id"));
    if (response.statusCode == 200) {
      var resdata = jsonDecode(response.body);
      if (resdata["response"] == "success") {
        return true;
      }
    }
    return false;
  }
}

class UserTypeProvider extends ChangeNotifier {
  FutureState state = FutureState.init;

  List<UserType> _usertypes = [];
  RemoteRepo remoteRepo = RemoteRepo();
  UserTypeProvider() {
    getUserTypes();
  }

  List<UserType> get userType => _usertypes;

  Future<void> getUserTypes() async {
    setState = FutureState.loading;
    try {
      _usertypes = await remoteRepo.list();
      setState = FutureState.loaded;
    } catch (ex) {
      setState = FutureState.error;
    }
  }

  Future<void> addUserType(UserType newUserType) async {
    setState = FutureState.loading;
    bool value = await remoteRepo.create(newUserType.toMap());
    if (value) {
      await getUserTypes();
    }
  }

  Future<void> deleteUserType(int id) async {
    setState = FutureState.loading;
    bool value = await remoteRepo.delete(id);
    if (value) {
      await getUserTypes();
    }
  }

  set setState(FutureState state) {
    this.state = state;
    notifyListeners();
  }
}
