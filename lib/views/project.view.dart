// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapnpospoc/notifier/view.notifier.dart';
import 'package:mapnpospoc/views/project.view/project.card.view.dart';
import 'package:mapnpospoc/views/project.view/project.detail.view.dart';

class ProjectView extends StatelessWidget {
  const ProjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(child: ProjectOptionBar()),
          SizedBox(
            height: 16,
          ),
          Expanded(child: ProjectCardView())
        ],
      ),
    );
  }
}

class FullScreenProjectDetail extends StatelessWidget {
  const FullScreenProjectDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ProjectDetail(),
    );
  }
}

class ProjectOptionBar extends ConsumerWidget {
  const ProjectOptionBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {
            // ref.watch(ViewNotifier.addprojectWidgetNotifier.notifier).show();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => FullScreenProjectDetail()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(
                  Icons.add_box_outlined,
                  size: 28,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "Add Project",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(
                  Icons.filter_alt_sharp,
                  size: 28,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "Filter",
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
          ),
        ),
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
