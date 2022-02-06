import 'package:flutter/cupertino.dart';

class VerticalAlignTableCell extends StatelessWidget {
  final Widget child;
  const VerticalAlignTableCell({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        margin: const EdgeInsets.all(6),
        child: child,
      ),
    );
  }
}
