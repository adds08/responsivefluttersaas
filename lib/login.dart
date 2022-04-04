import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//aras auth model
class AuthUserData {
  String username;
  String password;
  AuthUserData({
    this.username = "",
    this.password = "",
  });
}

//login screen
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
  }

  Future<dynamic> makeRequest(AuthUserData authuserdata) async {
    // var formData = dio.FormData.fromMap({
    //   "grant_type": "password",
    //   "scope": "Innovator",
    //   "client_id": "atishplayground",
    //   "username": authuserdata.username,
    //   "password": md5.convert(utf8.encode(authuserdata.password)).toString(),
    //   "database": "upaystaging001"
    // });
    //parse
    http
        .get(Uri.parse("http://44.202.199.120/upayeval/server/oauthserverdiscovery.aspx"))
        .timeout(Duration(seconds: 10))
        .then((value) => print(value.body));
    // http.Response resp = await http.post(Uri.parse("http://44.202.199.120/upayeval/OAuthServer/connect/token"),
    //     headers: {"Content-Type": "multipart/form-data;"}, body: data);
    // String rdata = jsonDecode(resp.body);
    return {};
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthUserData userData = AuthUserData();
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Center(
            child: Container(
              width: 300,
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 122,
                    ),
                    TextFormField(
                      onSaved: (newValue) => (userData.username = newValue ?? ""),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? val) {
                        if (val!.isEmpty) return "Enter valid text";
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 122,
                    ),
                    TextFormField(
                      onSaved: (newValue) => (userData.password = newValue ?? ""),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String? val) {
                        if (val!.isEmpty) return "Enter valid text";
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 122,
                    ),
                    TextButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            http
                                .get(Uri.parse("http://44.202.199.120/upayeval/server/oauthserverdiscovery.aspx"))
                                .timeout(Duration(seconds: 10))
                                .then((value) => print(value.body));
                            // print(jsonEncode(response));
                          } else {
                            print("error");
                          }
                        },
                        child: (!isLoading) ? Text("Login") : CircularProgressIndicator())
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
