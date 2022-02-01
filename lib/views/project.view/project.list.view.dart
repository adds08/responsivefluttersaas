// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/constants.dart';
import 'package:mapnpospoc/models/project.model.dart';
import 'package:mapnpospoc/notifier/data.notifier.dart';
import 'package:mapnpospoc/notifier/view.notifier.dart';
import 'package:mapnpospoc/viewmodels/viewModels/project.viewmodel.dart';

class ProjectListView extends ConsumerWidget {
  final double heightContainer = 420;
  final double widthContainer = 320;

  const ProjectListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final midHeight = ((4 * height / 10) - heightContainer / 2);
    final width = MediaQuery.of(context).size.width;
    // final widgetProvider = ;
    return Container(
      padding: EdgeInsets.all(8),
      key: GlobalObjectKey("dashboard_container"),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          ProjectsList(),
          (ref.watch(ViewNotifier.addprojectWidgetNotifier).state != DataFormState.hidden)
              ? Container(
                  color: Colors.transparent,
                )
              : Container(),
          AnimatedPositioned(
              bottom: ref.watch(ViewNotifier.addprojectWidgetNotifier).state != DataFormState.hidden ? midHeight : -heightContainer,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: SizedBox(width: (2.5 * width / 10), child: AddProject()))
        ],
      ),
      // child: MyStatefulWidget(),
    );
  }
}

class AddProject extends ConsumerWidget {
  AddProject({Key? key}) : super(key: key);

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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(ViewNotifier.addprojectWidgetNotifier.notifier);
    final projectNotifier = ref.watch(DataNotifier.projectDataNotifier.notifier).projects;
    final TextEditingController _controllerName = TextEditingController();
    final TextEditingController _controllerCode = TextEditingController(text: "0");
    final TextEditingController _controllerDescription = TextEditingController();
    final TextEditingController _controllerStartDate = TextEditingController();
    final TextEditingController _controllerEndDate = TextEditingController();

    if (provider.state == DataFormState.update) {
      _controllerName.text = projectNotifier[provider.updateIndex].name;
      _controllerCode.text = projectNotifier[provider.updateIndex].code.toString();
      _controllerDescription.text = projectNotifier[provider.updateIndex].description;
      _controllerStartDate.text = projectNotifier[provider.updateIndex].startdate;
      _controllerEndDate.text = projectNotifier[provider.updateIndex].enddate;
    }

    return Card(
        elevation: 12,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: appBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Project",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          ref.read(ViewNotifier.addprojectWidgetNotifier.notifier).hide();
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
                  child: TextFormField(
                      controller: _controllerName,
                      decoration: inputDecoration(placeholder: "Name"),
                      validator: (String? text) {
                        if (text!.isEmpty) return "Missing Field";
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerCode,
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration(placeholder: "Project Code"),
                    validator: (String? text) {
                      if (int.tryParse(text ?? "") == null) {
                        return "Code should be a number";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    minLines: 3,
                    maxLines: 5,
                    controller: _controllerDescription,
                    decoration: inputDecoration(placeholder: "Project Description"),
                    validator: (String? text) {
                      if (text!.isEmpty) return "Missing Field";
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            readOnly: true,
                            controller: _controllerStartDate,
                            onTap: () async {
                              DateTime startdate = await showDatePicker(
                                    context: context,
                                    currentDate: DateTime.now(),
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime(2050),
                                  ) ??
                                  DateTime.now();
                              _controllerStartDate.text = startdate.toString().split(" ")[0];
                            },
                            decoration: inputDecoration(placeholder: "Start Date", icon: Icons.calendar_today),
                            validator: (String? text) {
                              if (text == null || text == "null") return "Not a valid input";
                              if (text.isEmpty) return "Missing Field";
                            },
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: TextFormField(
                            readOnly: true,
                            controller: _controllerEndDate,
                            onTap: () async {
                              DateTime enddate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now().add(Duration(days: 10)),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime(2050),
                                  ) ??
                                  DateTime.now().add(Duration(days: 10));
                              _controllerEndDate.text = enddate.toString().split(" ")[0];
                            },
                            decoration: inputDecoration(placeholder: "End Date", icon: Icons.calendar_today),
                            validator: (String? text) {
                              if (text == null || text == "null") return "Not a valid input";
                              if (text.isEmpty) return "Missing Field";
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          _controllerName.clear();
                          _controllerCode.clear();
                          _controllerDescription.clear();
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
                            if (_formKey.currentState!.validate()) {
                              // _formKey.currentState!.save();
                              String name = _controllerName.text.trim();
                              int code = int.tryParse(_controllerCode.text.trim()) ?? 0;
                              String description = _controllerDescription.text.trim();
                              String startDate = _controllerStartDate.text.trim();
                              String endDate = _controllerEndDate.text.trim();
                              if (provider.state == DataFormState.create) {
                                Project newProject =
                                    Project(name: name, code: code, description: description, sdate: startDate, edate: endDate);
                                ref.read(DataNotifier.projectDataNotifier).addProject(newProject);
                                _formKey.currentState!.reset();
                              } else if (provider.state == DataFormState.update) {
                                Project newProject = Project(
                                    uuid: projectNotifier[provider.updateIndex].id,
                                    name: name,
                                    code: code,
                                    description: description,
                                    sdate: startDate,
                                    edate: endDate);
                                ref.read(DataNotifier.projectDataNotifier).updateProject(provider.updateIndex, newProject);
                              }
                            }
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
          ),
        ));
  }
}

class ProjectsList extends ConsumerWidget {
  const ProjectsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectProvider = ref.watch(DataNotifier.projectDataNotifier);
    List<DataRow> projectRow = [];
    for (int i = 0; i < projectProvider.projects.length; i++) {
      Project element = projectProvider.projects[i];
      List<DataCell> dataCells = [];

      // DataColumn(label: Text("S.No.")),
      // DataColumn(label: Text("Project Name")),
      // DataColumn(label: Text("Project Code")),
      // DataColumn(label: Text("Project Description")),
      // DataColumn(label: Text("Project Start Date")),
      // DataColumn(label: Text("Project End Date")),
      // DataColumn(label: Text("Project Status")),
      // DataColumn(label: Text("Action")),

      dataCells.add(DataCell(Center(child: Text((i + 1).toString()))));
      dataCells.add(DataCell(Center(child: Text(element.name))));
      dataCells.add(DataCell(Center(child: Text(element.code.toString()))));
      dataCells.add(DataCell(Center(child: Text(element.description))));
      dataCells.add(DataCell(Center(child: Text(element.startdate))));
      dataCells.add(DataCell(Center(child: Text(element.enddate))));
      dataCells.add(DataCell(Center(child: Text(element.status.toString()))));
      dataCells.add(DataCell(Center(
          child: Row(
        children: [
          IconButton(
            splashRadius: 18,
            onPressed: () {
              ref.watch(ViewNotifier.addprojectWidgetNotifier.notifier).showEdit(i);
            },
            icon: Icon(Icons.edit),
            color: Colors.orange,
          ),
          IconButton(
            onPressed: () {
              projectProvider.removeProject(i);
            },
            splashRadius: 18,
            icon: Icon(Icons.delete),
            color: Colors.redAccent,
          )
        ],
      ))));
      projectRow.add(DataRow(cells: dataCells));
    }

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: appBorderRadius),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "List Projects",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  MaterialButton(
                    color: Colors.amber,
                    onPressed: () {
                      ref.watch(ViewNotifier.addprojectWidgetNotifier.notifier).show();
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
                            "Add Project",
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
                  columnSpacing: (MediaQuery.of(context).size.width / 10) * 0.25,
                  columns: const [
                    DataColumn(label: Text("S.No.")),
                    DataColumn(label: Text("Project Name")),
                    DataColumn(label: Text("Project Code")),
                    DataColumn(label: Text("Project Description")),
                    DataColumn(label: Text("Project Start Date")),
                    DataColumn(label: Text("Project End Date")),
                    DataColumn(label: Text("Project Status")),
                    DataColumn(label: Text("Action")),
                  ],
                  rows: projectRow),
            ))
          ],
        ),
      ),
    );
  }
}
