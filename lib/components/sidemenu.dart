import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/main.dart';
import 'package:mapnpospoc/models/viewModels/sidemenu.viewmodel.dart';

class SideMenu extends ConsumerWidget {
  SideMenu({Key? key}) : super(key: key);

  Widget menuItem({icon = Icons.menu, String text = "Menu"}) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(
            height: 6,
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          )
        ],
      );

  MaterialButton synchronizeButton() => MaterialButton(
        elevation: 0,
        color: Colors.greenAccent,
        onPressed: () {},
        child: Center(child: SizedBox(height: 60, child: menuItem(icon: Icons.sync, text: "Sync"))),
      );

  List<Widget> widgetList(ref) {
    List<Widget> widgetsList = [];

    for (int i = 0; i < SideMenuViewModel().menuitems.length; i++) {
      var element = SideMenuViewModel().menuitems[i];
      widgetsList.add(Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: MaterialButton(
          elevation: 0,
          enableFeedback: true,
          color: (ref.watch(sideMenuProvider) == i) ? Colors.amber : Colors.white,
          onPressed: () {
            ref.read(sideMenuProvider.notifier).changeIndex = i;
          },
          child: Center(child: SizedBox(height: 100, child: menuItem(icon: element.menuIcon, text: element.menuTitle))),
        ),
      ));
    }
    return widgetsList;
  }

  final ScrollController scollBarController = ScrollController(debugLabel: "controller");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetList = this.widgetList(ref);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: RawScrollbar(
          thumbColor: Colors.black,
          interactive: true,
          controller: scollBarController,
          mainAxisMargin: 2,
          thickness: 12,
          radius: const Radius.circular(4),
          child: ListView.builder(
              controller: scollBarController,
              itemCount: widgetList.length,
              itemBuilder: (context, index) {
                return widgetList[index];
              }),
        )),
        synchronizeButton(),
      ],
    );
  }
}
