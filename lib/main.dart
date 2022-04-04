// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mapnpospoc/constants.dart';
import 'package:mapnpospoc/login.dart';
import 'package:mapnpospoc/views/project.view/project.detail.view.dart';
import 'package:mapnpospoc/views/components_custom/responsive_container.dart';
import 'package:mapnpospoc/models/project.model.dart';
import 'package:mapnpospoc/models/user.model.dart';
import 'package:mapnpospoc/viewmodels/viewModels/sidemenu.viewmodel.dart';
import 'package:mapnpospoc/views/sidemenu.dart';
import 'package:mapnpospoc/views/topbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ProjectAdapter());
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      /* light theme settings */
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Color(0xFFFFFFFF),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(smallHeaderForegroundColor),
                  overlayColor: MaterialStateProperty.all<Color>(smallHeaderOverlayColor),
                  backgroundColor: MaterialStateProperty.all(smallHeaderBackgroundColor))),
          buttonTheme: ButtonThemeData(buttonColor: smallHeaderBackgroundColor)),
      home: SafeArea(child: SplashScreen()),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(),
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
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: SideMenu(),
              ),
              SizedBox(
                width: 8,
                child: VerticalDivider(
                  width: 4,
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                  children: [
                    Topbar(),
                    Expanded(child: FragmentConsumer()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      mobile: Scaffold(
        drawer: SizedBox(
          width: screenSize.width / 10 * 6,
          child: Material(
            elevation: 12,
            child: SideMenu(),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
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
      ),
      desktop: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: SideMenu(),
                ),
                SizedBox(
                  width: 8,
                  child: VerticalDivider(
                    width: 2,
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    children: [
                      Topbar(),
                      Expanded(child: Container(margin: EdgeInsets.only(top: 18), child: FragmentConsumer())),
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

class MainAppProjectView extends StatelessWidget {
  const MainAppProjectView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      tablet: Scaffold(
        appBar: AppBar(),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: ProjectDetail(),
        ),
      ),
      mobile: Scaffold(
        appBar: AppBar(),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: ProjectDetail(),
        ),
      ),
      desktop: Scaffold(
        appBar: AppBar(),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: ProjectDetail(),
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
