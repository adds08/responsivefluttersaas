// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/views/components_custom/error_loading.dart';
import 'package:mapnpospoc/constants.dart';
import 'package:mapnpospoc/models/usertype.model.dart';
import 'package:mapnpospoc/notifier/data.notifier.dart';
import 'package:mapnpospoc/notifier/view.notifier.dart';
import 'package:mapnpospoc/viewmodels/dataModels/usertype.datamodel.dart';

class UserTypeView extends ConsumerWidget {
  final double heightContainer = 420;
  final double widthContainer = 320;

  const UserTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final midHeight = ((4 * height / 10) - heightContainer / 2);
    final widgetProvider = ref.watch(ViewNotifier.addusertypeWidgetNotifier);
    return Container(
      padding: EdgeInsets.all(8),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          UsersTypeList(),
          (widgetProvider)
              ? Container(
                  color: Colors.transparent,
                )
              : Container(),
          AnimatedPositioned(
              bottom: widgetProvider ? midHeight : -heightContainer,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: SizedBox(width: widthContainer, height: heightContainer, child: AddUserType()))
        ],
      ),
      // child: MyStatefulWidget(),
    );
  }
}

class AddUserType extends ConsumerWidget {
  const AddUserType({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _controllerName = TextEditingController();
    TextEditingController _controllerPriority = TextEditingController();

    return Card(
        elevation: 12,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: appBorderRadius),
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
                      "Add User Type",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(ViewNotifier.addusertypeWidgetNotifier.notifier).hide();
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
                    controller: _controllerPriority,
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration(placeholder: "Priority")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _controllerName.clear();
                        _controllerPriority.clear();
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
                          int priority = int.tryParse(_controllerPriority.text.trim()) ?? 0;
                          if (name.isNotEmpty && priority > 0) {
                            UserType newUserType = UserType(name: name, priority: priority);
                            ref.read(DataNotifier.usertypeDataNotifier.notifier).addUserType(newUserType);
                          }
                          _controllerName.clear();
                          _controllerPriority.clear();
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

class UsersTypeList extends ConsumerWidget {
  const UsersTypeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userTypeProvider = ref.watch(DataNotifier.usertypeDataNotifier);

    switch (userTypeProvider.state) {
      case FutureState.error:
        return ErrorLoading(
          onClick: () {
            ref.read(DataNotifier.usertypeDataNotifier).getUserTypes();
          },
        );
      case FutureState.loaded:
        List<DataRow> userRow = [];
        for (int i = 0; i < userTypeProvider.userType.length; i++) {
          var element = userTypeProvider.userType[i];
          List<DataCell> dataCells = [];
          dataCells.add(DataCell(Text((i + 1).toString())));
          dataCells.add(DataCell(Text(element.name)));
          dataCells.add(DataCell(Text(element.priority.toString())));
          dataCells.add(DataCell(IconButton(
            onPressed: () {
              userTypeProvider.deleteUserType(element.typeId);
            },
            icon: Icon(Icons.delete),
            color: Colors.redAccent,
          )));
          userRow.add(DataRow(cells: dataCells));
        }

        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: appBorderRadius),
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
                        "User Types",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      MaterialButton(
                        color: Colors.amber,
                        onPressed: () {
                          ref.read(ViewNotifier.addusertypeWidgetNotifier.notifier).show();
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
                                "Add User Type",
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
                        DataColumn(label: Text("Priority")),
                        DataColumn(label: Text("Action")),
                      ],
                      rows: userRow),
                ))
              ],
            ),
          ),
        );

      default:
        break;
    }
    return CircularProgressIndicator();
  }
}
