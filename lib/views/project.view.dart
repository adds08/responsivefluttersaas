// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/components_custom/header_text_button.dart';
import 'package:mapnpospoc/components_custom/responsive_container.dart';
import 'package:mapnpospoc/views/project.view/project.card.view.dart';
import 'package:mapnpospoc/views/project.view/project.detail.view.dart';

class ProjectView extends StatelessWidget {
  const ProjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ResponsiveContainer(
        desktop: Column(
          children: [
            ProjectOptionBar(),
            SizedBox(
              height: 16,
            ),
            Expanded(child: ProjectCardView())
          ],
        ),
        tablet: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProjectOptionBar(),
            SizedBox(
              height: 16,
            ),
            Expanded(child: ProjectCardView())
          ],
        ),
        mobile: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProjectOptionBar(),
                SizedBox(
                  height: 16,
                ),
                Expanded(child: ProjectCardView())
              ],
            ),
            Positioned(
              right: 12,
              bottom: 26,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FullScreenProjectDetail()));
                },
                child: Icon(
                  Icons.add,
                  size: 32,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProjectOptionBar extends ConsumerWidget {
  const ProjectOptionBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        (ResponsiveContainer.isMobile(context))
            ? Container()
            : HeaderTextButton(
                onPressed: () {
                  // ref.watch(ViewNotifier.addprojectWidgetNotifier.notifier).show();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FullScreenProjectDetail()));
                },
                icon: Icons.add_box_outlined,
                text: "Add Project",
              ),
        HeaderTextButton(onPressed: () {}, icon: Icons.filter_alt_sharp, text: "Filter"),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: () {}, child: Text("Card View")),
            TextButton(onPressed: () {}, child: Text("List View")),
          ],
        ))
      ],
    );
  }
}
