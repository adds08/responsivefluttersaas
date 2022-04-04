import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  final Widget tablet;

  const ResponsiveContainer({Key? key, required this.desktop, required this.tablet, required this.mobile}) : super(key: key);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 800;
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 800;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isDesktop(context)) {
          return desktop;
        } else if (isTablet(context)) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
