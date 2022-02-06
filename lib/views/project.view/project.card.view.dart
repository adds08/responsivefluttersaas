// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectCardView extends ConsumerWidget {
  final double heightContainer = 420;
  final double widthContainer = 320;

  const ProjectCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProjectGrid();
  }
}

class ProjectGrid extends ConsumerWidget {
  const ProjectGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final projectProvider = ref.watch(DataNotifier.projectDataNotifier);
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, childAspectRatio: 0.80, crossAxisSpacing: 12, mainAxisSpacing: 12),

      children: [
        Container(
          color: Colors.red,
          child: Card(
            child: Text("hi"),
          ),
        ),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.red,
        ),
      ],

      // child: MyStatefulWidget(),
    );
  }
}

class ProjectViewCard extends StatelessWidget {
  const ProjectViewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text("Project Title"),
            Text(
                "As an admin I want to mark inactivated employee with red text color in Group Management Report so that they can be easily distinguished."),
            Row(
              children: [
                LinearProgressIndicator(
                  color: Colors.pink,
                  value: 0.5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
