// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/models/users.model.dart';
import 'package:mapnpospoc/notifier/data.notifier.dart';
import 'package:mapnpospoc/notifier/view.notifier.dart';

class UserView extends ConsumerWidget {
  final double heightContainer = 420;
  final double widthContainer = 320;

  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final midHeight = ((4 * height / 10) - heightContainer / 2);
    final widgetProvider = ref.watch(ViewNotifier.adduserWidgetNotifier);
    return Container(
      padding: EdgeInsets.all(8),
      key: GlobalObjectKey("dashboard_container"),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          UsersList(),
          (widgetProvider)
              ? Container(
                  color: Colors.transparent,
                )
              : Container(),
          AnimatedPositioned(
              bottom: widgetProvider ? midHeight : -heightContainer,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: SizedBox(width: widthContainer, height: heightContainer, child: AddUser()))
        ],
      ),
      // child: MyStatefulWidget(),
    );
  }
}

class AddUser extends ConsumerWidget {
  const AddUser({Key? key}) : super(key: key);

  InputDecoration inputDecoration({required String placeholder, IconData? icon = Icons.arrow_right}) => InputDecoration(
      prefixIcon: Icon(icon),
      hintText: placeholder,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: EdgeInsets.all(10));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _controllerName = TextEditingController();
    TextEditingController _controllerAge = TextEditingController();
    TextEditingController _controllerGender = TextEditingController();

    return Card(
        elevation: 12,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add User",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(ViewNotifier.adduserWidgetNotifier.notifier).hide();
                      },
                      icon: Icon(Icons.cancel_outlined),
                      color: Colors.redAccent,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(controller: _controllerName, decoration: inputDecoration(placeholder: "Name")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: _controllerAge, keyboardType: TextInputType.number, decoration: inputDecoration(placeholder: "Age")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(controller: _controllerGender, decoration: inputDecoration(placeholder: "Gender")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _controllerName.clear();
                        _controllerAge.clear();
                        _controllerGender.clear();
                      },
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          String name = _controllerName.text.trim();
                          int age = int.tryParse(_controllerAge.text.trim()) ?? 0;
                          String gender = _controllerGender.text.trim();
                          if (gender.isNotEmpty && name.isNotEmpty && age > 0) {
                            User newUser =
                                User(name: _controllerName.text, age: int.parse(_controllerAge.text), gender: _controllerGender.text);
                            ref.read(DataNotifier.userDataNotifier.notifier).addUsers(newUser);
                          }
                          _controllerName.clear();
                          _controllerAge.clear();
                          _controllerGender.clear();
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class UsersList extends ConsumerWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(DataNotifier.userDataNotifier).getUsers();
    final userProvider = ref.watch(DataNotifier.userDataNotifier.notifier);
    List<DataRow> userRow = [];
    for (int i = 0; i < userProvider.users.length; i++) {
      var element = userProvider.users[i];
      List<DataCell> dataCells = [];
      dataCells.add(DataCell(Text((i + 1).toString())));
      dataCells.add(DataCell(Text(element.name)));
      dataCells.add(DataCell(Text(element.age.toString())));
      dataCells.add(DataCell(Text(element.gender)));
      dataCells.add(DataCell(IconButton(
        onPressed: () {
          userProvider.removeUsers(i);
        },
        icon: Icon(Icons.delete),
        color: Colors.redAccent,
      )));
      userRow.add(DataRow(cells: dataCells));
    }

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "List Users",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  MaterialButton(
                    color: Colors.amber,
                    onPressed: () {
                      ref.read(ViewNotifier.adduserWidgetNotifier.notifier).show();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_reaction,
                            size: 28,
                          ),
                          Text(
                            "Add User",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columnSpacing: (MediaQuery.of(context).size.width / 10) * 0.5,
                  columns: const [
                    DataColumn(label: Text("S.No.")),
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Age")),
                    DataColumn(label: Text("Gender")),
                    DataColumn(label: Text("Action")),
                  ],
                  rows: userRow),
            ))
          ],
        ),
      ),
    );
  }
}
