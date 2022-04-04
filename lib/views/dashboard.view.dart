// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/models/user.model.dart';
import 'package:mapnpospoc/notifier/data.notifier.dart';
import 'package:mapnpospoc/views/components_custom/responsive_container.dart';
import 'package:mapnpospoc/views/sections.dart';

class DasboardView extends ConsumerWidget {
  const DasboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var watcher = ref.watch(DataNotifier.userDataNotifier);
    var userslist = watcher.users;

    return Container(
        child: TextField(
      keyboardType: TextInputType.number,
    ));

    // return ResponsiveContainer(
    //   key: GlobalKey(debugLabel: "dashboard_container"),
    //   tablet: Container(),
    //   mobile: ListView(
    //     children: const [SectionLeft(), SectionRight()],
    //   ),
    //   desktop: Row(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Expanded(
    //         flex: 3,
    //         // child: SectionLeft(),
    //         child: MaterialButton(
    //           onPressed: () async {
    //             var result = await showDialog(
    //                 context: context,
    //                 builder: (_) {
    //                   return SearchableModal(
    //                     listTiles: userslist,
    //                     searchableFields: ["name"],
    //                   );
    //                 });
    //             print(result);
    //           },
    //           child: Text("Dropdown"),
    //         ),
    //       ),
    //       Expanded(flex: 2, child: SectionRight())
    //     ],
    //   ),
    // );
  }
}

class SearchableModal extends StatefulWidget {
  final List<dynamic> listTiles;
  final List<String> searchableFields;

  const SearchableModal({Key? key, required this.listTiles, required this.searchableFields}) : super(key: key);

  @override
  SearchableModalState createState() => SearchableModalState();
}

class SearchableModalState extends State<SearchableModal> {
  List<dynamic> originalList = [];
  List<dynamic> filteredList = [];
  List<String> searchableFields = [];
  @override
  void initState() {
    super.initState();
    searchableFields.addAll(widget.searchableFields);
    for (int i = 0; i < widget.listTiles.length; i++) {
      originalList.add(widget.listTiles[i].toMap());
    }
    filteredList.addAll(originalList);
  }

  void searchAndFilter(String query) {
    List<dynamic> dummySearchList = [];
    dummySearchList.addAll(originalList);

    if (query.isNotEmpty) {
      List<dynamic> dummyListData = [];
      for (var item in dummySearchList) {
        for (String searchable in searchableFields) {
          if (item[searchable].toString().toLowerCase().contains(query.toLowerCase())) {
            dummyListData.add(item);
          }
        }
      }
      setState(() {
        filteredList.clear();
        filteredList.addAll(dummyListData);
      });
    } else {
      setState(() {
        filteredList.clear();
        filteredList.addAll(originalList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height / 1.2,
        width: MediaQuery.of(context).size.width / 4,
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                searchAndFilter(text);
              },
            ),
            Expanded(
              child: ListView(
                children: filteredList.map((e) {
                  return ListTile(
                    title: Text(e[searchableFields[0]].toString()),
                    subtitle: (searchableFields.length > 1) ? Text(e[searchableFields[1]].toString()) : Text(""),
                    onTap: () {
                      Navigator.pop(context, e);
                    },
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
