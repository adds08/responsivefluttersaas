import 'package:flutter/material.dart';
import 'package:mapnpospoc/components_custom/responsive_container.dart';
import 'package:mapnpospoc/constants.dart';

class ProjectDetail extends StatelessWidget {
  ProjectDetail({Key? key}) : super(key: key);
  final ScrollController scollBarController = ScrollController(debugLabel: "controller");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(26),
      child: ResponsiveContainer(
        mobile: Column(
          children: [
            Padding(
              child: OptionBar(),
              padding: EdgeInsets.only(bottom: 8),
            ),
            Expanded(
                child: Scrollbar(
              isAlwaysShown: true,
              controller: scollBarController,
              child: SingleChildScrollView(
                controller: scollBarController,
                child: Column(
                  children: [ProjectDetailSetup(), ProjectComment()],
                ),
              ),
            ))
          ],
        ),
        tablet: Container(),
        desktop: Column(
          children: [
            Padding(
              child: OptionBar(),
              padding: const EdgeInsets.only(bottom: 8),
            ),
            Expanded(
                child: Row(
              children: [
                Expanded(flex: 2, child: ProjectDetailSetup()),
                Expanded(flex: 1, child: ProjectComment()),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class OptionBar extends StatelessWidget {
  const OptionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Text("Projects / Project One")),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Icon(
              Icons.ac_unit,
              size: sideMenuIconSize,
            ),
          ),
          hoverColor: Colors.grey.shade300,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Icon(Icons.share, size: sideMenuIconSize),
          ),
          hoverColor: Colors.grey.shade300,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Icon(Icons.settings, size: sideMenuIconSize),
          ),
          hoverColor: Colors.grey.shade300,
        ),
      ],
    );
  }
}

class ProjectDetailSetup extends StatelessWidget {
  const ProjectDetailSetup({Key? key}) : super(key: key);

  Widget projectDetailSetup({isMobile, child}) {
    if (isMobile) {
      return SizedBox(
        height: 500,
        child: child,
      );
    }
    return Expanded(
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          maxLines: null,
          keyboardType: TextInputType.multiline,
          style: TextStyle(fontSize: ResponsiveContainer.isMobile(context) ? 22 : 32, fontWeight: FontWeight.w500),
          initialValue:
              "As an admin I want to mark inactivated employee with red text color in Group Management Report so that they can be easily distinguished.",
          decoration: InputDecoration(
            hintText: "Search",
            filled: true,
            fillColor: Colors.transparent,
            hoverColor: Colors.grey.shade300,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: appBorderRadius,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
              borderRadius: appBorderRadius,
            ),
          ),
        ),
        projectDetailSetup(isMobile: ResponsiveContainer.isMobile(context), child: Text("Hello Container"))
      ],
    );
  }
}

class ProjectComment extends StatelessWidget {
  ProjectComment({Key? key}) : super(key: key);

  Widget addCommentWidget() {
    return commentRow(
        comment:
            "As an admin I want to mark inactivated employee with red text color in Group Management Report so that they can be easily distinguished.",
        name: "P",
        color: Colors.orange.shade100);
  }

  Widget commentRow({String name = "A", String comment = "Comment Section A", required Color color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: color,
              child: Text(
                name,
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                minLines: 2,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                initialValue: comment,
                decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    fillColor: color,
                    hoverColor: Colors.grey.shade300,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: appBorderRadius,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color),
                      borderRadius: appBorderRadius,
                    ),
                    contentPadding: EdgeInsets.all(12)),
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
              Divider(
                height: 8,
              ),
              addCommentWidget(),
            ],
          )
        : Column(
            children: [
              addCommentWidget(),
              Divider(
                height: 38,
              ),
              Expanded(child: ListView(children: userCommentsMock))
            ],
          ));
  }
}
