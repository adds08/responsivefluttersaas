import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/views/dashboard.view.dart';
import 'package:mapnpospoc/views/project.view.dart';
import 'package:mapnpospoc/views/user.view.dart';
import 'package:mapnpospoc/views/usertype.view/usertype.view.dart';

class SideMenuModel {
  late IconData _icon;
  late String _name;
  late Widget _fragment;

  SideMenuModel({required IconData icon, required String name, required Widget fragment}) {
    _icon = icon;
    _name = name;
    _fragment = fragment;
  }

  IconData get menuIcon => _icon;
  String get menuTitle => _name;
  Widget get menuWidget => _fragment;
}

class SideMenuProvider extends StateNotifier<int> {
  SideMenuProvider() : super(0);
  set changeIndex(int fragmentIndex) {
    state = fragmentIndex;
  }
}

class SideMenuViewModel {
  SideMenuViewModel();

  List<SideMenuModel> sidemenuItems = [
    SideMenuModel(icon: Icons.dashboard, name: "Dashboard", fragment: const DasboardView()),
    SideMenuModel(icon: Icons.task, name: "Projects", fragment: const ProjectView()),
    SideMenuModel(icon: Icons.people, name: "Users", fragment: const UserView()),
    SideMenuModel(icon: Icons.people, name: "User Types", fragment: const UserTypeView()),
    SideMenuModel(icon: Icons.analytics, name: "Report", fragment: Container()),
  ];

  List<SideMenuModel> get menuitems {
    return sidemenuItems;
  }
}
