// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/views/components_custom/custom_dropdown.dart';
import 'package:mapnpospoc/views/components_custom/header_text_button.dart';
import 'package:mapnpospoc/views/components_custom/responsive_container.dart';
import 'package:mapnpospoc/views/components_custom/vertical_table_cell.dart';
import 'package:mapnpospoc/constants.dart';
import 'package:mapnpospoc/notifier/data.notifier.dart';
import 'package:mapnpospoc/views/project.view/event.kanban.view.dart';

class FullScreenProjectDetail extends StatelessWidget {
  const FullScreenProjectDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
              width: 42,
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.ac_unit,
                    size: sideMenuIconSize,
                  ),
                ),
              )),
          SizedBox(
              width: 42,
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.share, size: sideMenuIconSize),
                ),
              )),
          SizedBox(
            width: 42,
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.settings, size: sideMenuIconSize),
              ),
            ),
          ),
          const SizedBox(
            width: 18,
          )
        ],
      ),
      body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: const ProjectDetail()),
    );
  }
}

class ProjectDetail extends StatefulWidget {
  const ProjectDetail({Key? key}) : super(key: key);

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  late double detailWidth;
  late double kanbanOffset;
  Duration kanbanDuration = Duration(milliseconds: 300);
  double detailOpacity = 1;
  late bool showDetail;
  bool isHover = false;

  ScrollController scontroller = ScrollController();

  @override
  void initState() {
    super.initState();
    showDetail = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ResponsiveContainer.isDesktop(context)) {
      detailWidth = 3 * MediaQuery.of(context).size.width / 10;
      kanbanOffset = detailWidth + 12;
    }
  }

  void toggleDetail() {
    showDetail = !showDetail;
    setState(() {
      if (showDetail) {
        kanbanOffset = 0;
      } else {
        kanbanOffset = detailWidth + 12;
      }
    });
  }

  void dragKanban(details) {
    setState(() {
      kanbanDuration = Duration.zero;
      kanbanOffset = details.globalPosition.dx - 55;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ResponsiveContainer.isMobile(context) ? 8 : 18),
      child: ResponsiveContainer(
        mobile: ListView(
          children: const [ProjectDescriptionHeader(), ProjectDescriptionKanban()],
        ),
        tablet: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: const [
                          ProjectDescriptionHeader(),
                          Expanded(
                            child: ProjectDescriptionDetails(),
                          )
                        ],
                      )),
                  const Flexible(flex: 1, child: ProjectDescriptionKanban()),
                ],
              ),
            )
          ],
        ),
        desktop: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              width: detailWidth,
              child: AnimatedOpacity(
                duration: Duration.zero,
                opacity: detailOpacity,
                child: Column(
                  children: const [
                    ProjectDescriptionHeader(),
                    Expanded(
                      child: ProjectDescriptionDetails(),
                    )
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
                left: kanbanOffset,
                right: 0,
                top: 0,
                bottom: 0,
                duration: kanbanDuration,
                curve: Curves.easeInOutSine,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          VerticalDivider(),
                          InkWell(
                            onTap: () {
                              toggleDetail();
                            },
                            onHover: (hover) {
                              setState(() {
                                isHover = hover;
                              });
                            },
                            child: Icon(
                              Icons.swap_horizontal_circle_rounded,
                              color: (isHover) ? Colors.black : Colors.grey,
                              size: 38,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: RawScrollbar(
                        isAlwaysShown: true,
                        scrollbarOrientation: ScrollbarOrientation.bottom,
                        thickness: 16,
                        controller: scontroller,
                        child: SingleChildScrollView(
                          controller: scontroller,
                          scrollDirection: Axis.horizontal,
                          child: HorizontalExample(),
                        ),
                      ))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class ProjectDescriptionHeader extends StatelessWidget {
  const ProjectDescriptionHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    double headingSize = 28;
    if (ResponsiveContainer.isTablet(context)) {
      headingSize = 24;
    } else if (ResponsiveContainer.isMobile(context)) {
      headingSize = 22;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(4.0),
          child: Text(
            "Projects / Project One",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          onTap: () {
            // showSaveButton()
          },
          maxLines: null,
          keyboardType: TextInputType.multiline,
          style: TextStyle(fontSize: headingSize, fontWeight: FontWeight.w500),
          controller: titleController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            hintText: "Add a title here",
            filled: true,
            fillColor: Colors.transparent,
            hoverColor: Colors.grey.shade300,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: appBorderRadius,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.amber),
              borderRadius: appBorderRadius,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              HeaderTextButton(
                onPressed: () {},
                icon: Icons.add,
                text: "Add Task",
              ),
              HeaderTextButton(
                onPressed: () {},
                text: "asd",
              ),
              HeaderTextButton(
                onPressed: () {},
                text: "asd",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProjectDescriptionKanban extends StatelessWidget {
  const ProjectDescriptionKanban({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, top: 8),
      child: HorizontalExample(),
    );
  }
}

class ProjectDescriptionDetails extends StatelessWidget {
  const ProjectDescriptionDetails({Key? key}) : super(key: key);

  InputDecoration inputDecoration({required String placeholder, IconData? icon = Icons.arrow_right}) => InputDecoration(
      prefixIcon: Icon(icon),
      hintText: placeholder,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: appBorderRadius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: appBorderRadius,
      ),
      contentPadding: const EdgeInsets.all(10));
  @override
  Widget build(BuildContext context) {
    final _controllerEndDate = TextEditingController();
    final _controllerStartDate = TextEditingController();

    return Table(
      columnWidths: const {0: IntrinsicColumnWidth(flex: 1), 1: IntrinsicColumnWidth(flex: 5)},
      border: TableBorder.all(width: 6, color: Colors.white),
      children: [
        TableRow(children: [
          const VerticalAlignTableCell(child: Text("Start Date")),
          VerticalAlignTableCell(
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
            decoration: inputDecoration(placeholder: "Enter the start date", icon: Icons.calendar_today),
            validator: (String? text) {
              if (text == null || text == "null") return "Not a valid input";
              if (text.isEmpty) return "Missing Field";
            },
          ))
        ]),
        TableRow(children: [
          const VerticalAlignTableCell(child: Text("End Date")),
          VerticalAlignTableCell(
              child: TextFormField(
            readOnly: true,
            controller: _controllerEndDate,
            onTap: () async {
              DateTime enddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 10)),
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2050),
                  ) ??
                  DateTime.now().add(const Duration(days: 10));
              _controllerEndDate.text = enddate.toString().split(" ")[0];
            },
            decoration: inputDecoration(placeholder: "Enter the end date", icon: Icons.calendar_today),
            validator: (String? text) {
              if (text == null || text == "null") return "Not a valid input";
              if (text.isEmpty) return "Missing Field";
            },
          ))
        ]),
        TableRow(children: [
          const VerticalAlignTableCell(child: Text("Client")),
          VerticalAlignTableCell(
              child: Container(
            color: Colors.black,
          ))
        ]),
        TableRow(children: [
          const VerticalAlignTableCell(child: Text("Lead")),
          VerticalAlignTableCell(child: Consumer(builder: (context, ref, _) {
            var userProvider = ref.watch(DataNotifier.userDataNotifier);
            return CustomDropdown(
              child: const Text("Select client"),
              children: userProvider.users
                  .map((e) => ListTile(
                        selectedTileColor: Colors.amber,
                        selectedColor: Colors.black,
                        title: Text(e.name),
                        subtitle: Text(e.email),
                        leading: Text(e.age.toString()),
                        onTap: () {},
                      ))
                  .toList(),
            );
          }))
        ]),
      ],
    );
  }
}

class ProjectComment extends StatelessWidget {
  const ProjectComment({Key? key}) : super(key: key);

  Widget addCommentWidget() {
    return commentRow(
        comment:
            "As an admin I want to mark inactivated employee with red text color in Group Management Report so that they can be easily distinguished.",
        name: "P",
        color: Colors.orange.shade100);
  }

  Widget commentRow({String name = "A", String comment = "Comment Section A", required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: color,
              child: Text(
                name,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                initialValue: comment,
                decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    fillColor: color,
                    hoverColor: Colors.grey.shade300,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: appBorderRadius,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color),
                      borderRadius: appBorderRadius,
                    ),
                    contentPadding: const EdgeInsets.all(12)),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> userCommentsMock = [
      commentRow(color: Colors.purple.shade100),
      commentRow(color: Colors.red.shade100),
      commentRow(color: Colors.yellow.shade100),
      commentRow(color: Colors.green.shade100),
      commentRow(color: Colors.green.shade100),
    ];
    return (ResponsiveContainer.isMobile(context)
        ? Column(
            children: [
              ...userCommentsMock,
              const Divider(
                height: 8,
              ),
              addCommentWidget(),
            ],
          )
        : Column(
            children: [
              addCommentWidget(),
              const Divider(
                height: 38,
              ),
              Expanded(child: ListView(children: userCommentsMock))
            ],
          ));
  }
}
