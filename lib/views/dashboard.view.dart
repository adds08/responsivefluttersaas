// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mapnpospoc/components/sections.dart';
import 'package:mapnpospoc/components_custom/responsive_container.dart';

class DasboardView extends StatelessWidget {
  const DasboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      key: GlobalKey(debugLabel: "dashboard_container"),
      tablet: Container(),
      mobile: ListView(
        children: const [SectionLeft(), SectionRight()],
      ),
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            flex: 3,
            child: SectionLeft(),
          ),
          Expanded(flex: 2, child: SectionRight())
        ],
      ),
    );
  }
}
