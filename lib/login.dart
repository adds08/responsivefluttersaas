import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;
import 'package:mapnpospoc/constants.dart';
import 'package:mapnpospoc/main2.dart' as foodmainapp;
import 'package:mapnpospoc/models/auth.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//aras auth model
class AuthUserData {
  String username;
  String password;
  AuthUserData({
    this.username = "",
    this.password = "",
  });
}

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                var pref = await SharedPreferences.getInstance();
                pref.remove("access_key");
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: foodmainapp.MainApp(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isCredentialCorrect = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //     body: Center(
        //         child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   mainAxisSize: MainAxisSize.max,
        //   children: [CircularProgressIndicator(), Text("Loading...")],
        // )));
        body: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var prefData = snapshot.data;
                var accessKey = prefData!.getString("access_key") ?? "";
                if (accessKey == "") {
                  return LoginScreen();
                } else {
                  return UserScreen();
                }
              }
              return Center(
                  child: Column(
                children: [CircularProgressIndicator(), Text("Loading...")],
              ));
            }));
  }
}

//login screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String state = "noauth";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  InputDecoration inputDecoration({required String placeholder, IconData? icon = Icons.arrow_right}) => InputDecoration(
      prefixIcon: Icon(icon),
      hintText: placeholder,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: appBorderRadius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: appBorderRadius,
      ),
      contentPadding: EdgeInsets.all(10));

  Future<void> makeRequest(AuthUserData authuserdata) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Headers": "Origin, Content-Type, Accept"
    };

    // var newHeaders = {
    //     "content-type": "application/x-www-form-urlencoded",
    //     // "Accept": "*/*",
    //     // "Accept-Encoding": "gzip, deflate",
    //     // "Accept-Language": "en-US,en;q=0.9",
    //     // "Access-Control-Allow-Headers": "Content-Type, Authorization",
    //     // "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
    //     // "Access-Control-Allow-Origin": "http://18.233.164.43",
    //     // "Connection": "keep-alive",
    //     // "Content-Length": "144",
    //     // "Host": "44.202.199.120",
    //     // "Referer": "http://18.233.164.43/",
    //     // "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36",
    //   };

    var request = http.Request('POST', Uri.parse('http://44.202.199.120/upayeval/OAuthServer/connect/token'));
    request.bodyFields = {
      'username': authuserdata.username,
      'password': crypto.md5.convert(utf8.encode(authuserdata.password.trim())).toString(),
      'scope': 'Innovator',
      'client_id': 'atishplayground',
      'database': 'upaystaging001',
      'grant_type': 'password'
    };
    request.headers.addAll(headers);
    setState(() {
      state = "isloading";
    });
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var value = await response.stream.bytesToString();
        AuthModel authModel = AuthModel.fromJson(value);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("access_token", authModel.accessToken);
        setState(() {
          state = "auth";
        });
      } else {
        setState(() {
          state = "error";
        });
        print(response.reasonPhrase);
      }
    } catch (err) {
      setState(() {
        state = "error";
      });
      print(err);
    }
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthUserData userData = AuthUserData();
    var width = (MediaQuery.of(context).size.width);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Form(
            key: formkey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3 * width / 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: inputDecoration(placeholder: "Username"),
                    onSaved: (newValue) => (userData.username = newValue ?? ""),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? val) {
                      if (val!.isEmpty) return "Enter valid text";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    decoration: inputDecoration(placeholder: "Password"),
                    onSaved: (newValue) => (userData.password = newValue ?? ""),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (String? val) {
                      if (val!.isEmpty) return "Enter valid text";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  MaterialButton(
                      color: Colors.amber,
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          formkey.currentState!.save();
                          await makeRequest(userData);
                        } else {
                          print("error");
                        }
                      },
                      child: state == "loading" ? CircularProgressIndicator() : Text("Login")),
                  SizedBox(
                    height: 32,
                  ),
                  (state == "auth")
                      ? MaterialButton(
                          child: Text("Go to main"),
                          onPressed: () async {
                            Navigator.pushNamed(context, "/user");
                          })
                      : Text("$state")
                ],
              ),
            ),
          ),
        ));
  }
}
