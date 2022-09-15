import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mapnpospoc/models/auth.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArasApi {
  static const baseURL = "http://44.202.199.120/upayeval";

  static getAllDocuments() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getString("access_token") ?? "";
    AuthModel authModel = AuthModel.fromJson(jsonDecode(value));
    // request.headers.addAll();
    http.Response response =
        await http.get(Uri.parse(baseURL + "Server/odata/Document"), headers: {"Authorization": "Bearer " + authModel.accessToken});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["value"];
    }
    return {};
  }
}
