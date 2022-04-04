// import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
// import 'package:flutter/material.dart';
// import 'package:mapnpospoc/components_custom/responsive_container.dart';

// class HorizontalExample extends StatefulWidget {
//   HorizontalExample({Key? key}) : super(key: key);

//   @override
//   _HorizontalExample createState() => _HorizontalExample();
// }

// class ProgressStack {
//   final String name;
//   List<Widget> events;
//   ProgressStack({required this.name, required this.events});
// }

// class _HorizontalExample extends State<HorizontalExample> {
//   late List<ProgressStack> _lists;
//   List<String> headerList = ["To Do", "In Process", "Done"];
//   @override
//   void initState() {
//     super.initState();

//     _lists = headerList
//         .map((e) => ProgressStack(
//               name: e.toString(),
//               events: List.generate(5, (innerIndex) => listText("$e . $innerIndex")),
//             ))
//         .toList();
//   }

//   Widget listText(String text) => Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 6),
//         child: Card(
//           elevation: 2,
//           child: ListTile(
//             hoverColor: Colors.grey,
//             title: Text(text),
//           ),
//         ),
//       );
//   Widget headerText(String text) => Text(
//         text,
//         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//       );

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return ResponsiveContainer(
//       desktop: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: DragAndDropLists(
//           itemDragHandle: DragHandle(
//             child: Container(
//               margin: EdgeInsets.only(right: 20),
//               child: Icon(Icons.drag_indicator),
//             ),
//           ),
//           disableScrolling: true,
//           children: List.generate(_lists.length, (index) => _buildProgressList(index)),
//           onItemReorder: _onItemReorder,
//           onListReorder: _onListReorder,
//           axis: Axis.horizontal,
//           listWidth: (2.1 * width / 10),
//           listDraggingWidth: (2 * width / 10),
//           listPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//         ),
//       ),
//       tablet: DragAndDropLists(
//         scrollController: ScrollController(),
//         children: List.generate(_lists.length, (index) => _buildProgressListForMobile(index)),
//         onItemReorder: _onItemReorder,
//         onListReorder: _onListReorder,
//         axis: Axis.vertical,
//         disableScrolling: true,
//         listGhost: const SizedBox(
//           height: 60,
//         ),
//         itemSizeAnimationDurationMilliseconds: 300,
//       ),
//       mobile: DragAndDropLists(
//         scrollController: ScrollController(),
//         children: List.generate(_lists.length, (index) => _buildProgressListForMobile(index)),
//         onItemReorder: _onItemReorder,
//         onListReorder: _onListReorder,
//         axis: Axis.vertical,
//         disableScrolling: true,
//         listGhost: const SizedBox(
//           height: 60,
//         ),
//         itemSizeAnimationDurationMilliseconds: 300,
//       ),
//     );
//   }

//   _buildProgressList(index) {
//     var progressStack = _lists[index];
//     return DragAndDropList(
//         canDrag: false,
//         decoration: BoxDecoration(color: Color(0xfff4f5f7), borderRadius: BorderRadius.circular(4)),
//         header: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//           child: headerText(progressStack.name),
//         ),
//         children: List.generate(progressStack.events.length, (i) => DragAndDropItem(child: progressStack.events[i])));
//   }

//   _buildProgressListForMobile(index) {
//     var progressStack = _lists[index];
//     return DragAndDropListExpansion(
//         backgroundColor: Color(0xfff4f5f7),
//         canDrag: false,
//         title: headerText(progressStack.name),
//         leading: Container(
//           padding: const EdgeInsets.all(2),
//           decoration: BoxDecoration(
//             color: Colors.red,
//             borderRadius: BorderRadius.circular(6),
//           ),
//           constraints: const BoxConstraints(
//             minWidth: 16,
//             minHeight: 16,
//           ),
//           child: const Text(
//             '5',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         children: List.generate(progressStack.events.length, (i) => DragAndDropItem(child: progressStack.events[i])),
//         listKey: ObjectKey(progressStack));
//   }

//   _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
//     setState(() {
//       var movedItem = _lists[oldListIndex].events.removeAt(oldItemIndex);
//       _lists[newListIndex].events.insert(newItemIndex, movedItem);
//     });
//   }

//   _onListReorder(int oldListIndex, int newListIndex) {
//     setState(() {
//       var movedList = _lists.removeAt(oldListIndex);
//       _lists.insert(newListIndex, movedList);
//     });
//   }
// }
