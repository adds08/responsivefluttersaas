import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/constants.dart';
import 'package:mapnpospoc/main_latest.dart';
import 'package:mapnpospoc/viewmodels/viewModels/sidemenu.viewmodel.dart';

class SideMenu extends ConsumerWidget {
  SideMenu({Key? key}) : super(key: key);

  ListTile synchronizeButton() => ListTile(
        tileColor: Colors.greenAccent,
        textColor: Colors.black,
        iconColor: Colors.black,
        enableFeedback: true,
        onTap: () {},
        leading: const Icon(Icons.sync),
        title: const Text("Sync"),
        horizontalTitleGap: 4,
      );

  // MaterialButton(
  //       selected: (ref.watch(sideMenuProvider) == i),
  //       selectedTileColor: Colors.amber,
  //       selectedColor: Colors.black,
  //       enableFeedback: true,
  //       onTap: () {
  //         ref.read(sideMenuProvider.notifier).changeIndex = i;
  //       },
  //       leading: Icon(element.menuIcon),
  //       title: Text(element.menuTitle),
  //       horizontalTitleGap: 0,
  //     )

  List<Widget> widgetList(ref, context) {
    List<Widget> widgetsList = [];

    for (int i = 0; i < SideMenuViewModel().menuitems.length; i++) {
      var element = SideMenuViewModel().menuitems[i];
      widgetsList.add(TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.black),
            overlayColor: MaterialStateProperty.all(Colors.amberAccent.withOpacity(0.25)),
            backgroundColor: (ref.watch(sideMenuProvider) == i) ? MaterialStateProperty.all(Colors.amber) : null,
            enableFeedback: true,
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20))),
        onPressed: () {
          ref.read(sideMenuProvider.notifier).changeIndex = i;
          if (Scaffold.of(context).hasDrawer && Scaffold.of(context).isDrawerOpen) {
            Navigator.of(context).pop();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              element.menuTitle,
              style: const TextStyle(fontSize: sideMenuTitleSize),
            ),
            Icon(
              element.menuIcon,
              size: sideMenuIconSize,
            ),
          ],
        ),
      ));
    }
    return widgetsList;
  }

  final ScrollController scollBarController = ScrollController(debugLabel: "controller");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetList = this.widgetList(ref, context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Container(
            height: 100,
          )),
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
          synchronizeButton()
        ],
      ),
    );
  }
}
