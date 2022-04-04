// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/views/components_custom/custom_dropdown.dart';
import 'package:mapnpospoc/views/components_custom/responsive_container.dart';
import 'package:mapnpospoc/constants.dart';

enum ServerStatus { connecting, online, offline, error }

class Topbar extends StatelessWidget {
  const Topbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(mobile: TopbarMobile(), tablet: TopbarDesktop(), desktop: TopbarDesktop());
  }
}

class TopbarMobile extends StatelessWidget {
  const TopbarMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    if (Scaffold.of(context).hasDrawer) {
                      Scaffold.of(context).openDrawer();
                    }
                  },
                  icon: Icon(Icons.menu)),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search",
                        filled: true,
                        fillColor: Colors.white54,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: appBorderRadius,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: appBorderRadius,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10)),
                  ),
                ),
              ),
              WebServerStatusIcon(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit_rounded)),
              IconButton(onPressed: () {}, icon: Icon(Icons.notification_add_rounded)),
              CustomDropdown(
                  children: [
                    ListTile(
                      title: Text("hi"),
                    )
                  ],
                  child: Row(
                    children: [
                      Icon(Icons.child_care_sharp),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Atish"),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class TopbarDesktop extends StatelessWidget {
  const TopbarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: TextField(
              decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  filled: true,
                  fillColor: Colors.white54,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: appBorderRadius,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: appBorderRadius,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 4)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit_rounded)),
                ),
                WebServerStatusIcon(),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: IconButton(onPressed: () {}, icon: Icon(Icons.notification_add_rounded))),
                CustomDropdown(
                    children: [
                      ListTile(
                        title: Text("hi"),
                      )
                    ],
                    child: Row(
                      children: [
                        Icon(Icons.child_care_sharp),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Atish"),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class WebServerStatusIcon extends ConsumerWidget {
  const WebServerStatusIcon({Key? key}) : super(key: key);

  Future<ServerStatus> getWebStatus() async {
    try {
      http.Response response = await http.get(Uri.parse(('http://localhost:8000/'))).timeout(Duration(seconds: 6));
      var result = jsonDecode(response.body);
      if (result["response"] == "success" && response.statusCode == 200) {
        return ServerStatus.online;
      } else {
        return ServerStatus.offline;
      }
    } on TimeoutException {
      return ServerStatus.offline;
    } on SocketException {
      return ServerStatus.offline;
    } on Exception {
      return ServerStatus.offline;
    } on Error {
      return ServerStatus.offline;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color color = Colors.blue;
    String text = "Connecting";
    return StreamBuilder<ServerStatus>(
        initialData: ServerStatus.connecting,
        stream: Stream.periodic(Duration(seconds: 10)).asyncMap((event) => getWebStatus()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == ServerStatus.online) {
              color = Colors.green;
              text = "Online";
            } else if (snapshot.data == ServerStatus.offline) {
              color = Colors.red;
              text = "Offline";
            } else {
              color = Colors.blue;
              text = "Connecting";
            }
          } else {
            color = Colors.blue;
            text = "Connecting";
          }
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 1.25),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Row(children: [
                  Icon(
                    Icons.circle,
                    color: color,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(text)
                ])),
          );
        });
  }
}
