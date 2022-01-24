// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mapnpospoc/components/sidemenu.dart';
import 'package:mapnpospoc/components/topbar.dart';
import 'package:mapnpospoc/components_custom/responsive_container.dart';
import 'package:mapnpospoc/models/users.model.dart';
import 'package:mapnpospoc/models/viewModels/sidemenu.viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(child: MainApp()),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ResponsiveContainer(
      tablet: Scaffold(
        backgroundColor: Colors.redAccent,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Material(
                  elevation: 12,
                  child: SideMenu(),
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Expanded(flex: 1, child: Topbar()),
                    Expanded(flex: 9, child: FragmentConsumer()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      mobile: Scaffold(
        backgroundColor: Colors.greenAccent,
        drawer: SizedBox(
          width: screenSize.width / 10 * 3,
          child: Material(
            elevation: 6,
            child: SideMenu(),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 6,
                    ),
                    Topbar(),
                    Expanded(child: FragmentConsumer()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      desktop: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: (screenSize.width / 10 * 0.5)),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Material(
                    elevation: 12,
                    child: SideMenu(),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Expanded(flex: 1, child: Topbar()),
                      Expanded(flex: 9, child: FragmentConsumer()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final sideMenuProvider = StateNotifierProvider<SideMenuProvider, int>((ref) => SideMenuProvider());

class FragmentConsumer extends ConsumerWidget {
  const FragmentConsumer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuItemProvider = ref.watch(sideMenuProvider);
    return Container(
      child: SideMenuViewModel().menuitems[menuItemProvider].menuWidget,
    );
  }
}
