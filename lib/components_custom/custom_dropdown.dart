import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<Widget> children;
  final Widget child;
  final double offsetHeight = 0;
  const CustomDropdown({Key? key, required this.children, required this.child}) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late final FocusNode _focusNode = FocusNode();
  late OverlayEntry _overlayEntry;
  late Size size;
  late Offset offset;

  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        openMenu();
      } else {
        closeMenu();
      }
    });
  }

  void openMenu() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)?.insert(_overlayEntry);
    setState(() {
      isMenuOpen = true;
    });
  }

  void closeMenu() {
    _overlayEntry.remove();
    setState(() {
      isMenuOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject()! as RenderBox;
    size = renderBox.size;
    offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
        builder: (context) => Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              width: size.width,
              child: Card(
                elevation: 4.0,
                child: ListView(padding: EdgeInsets.zero, shrinkWrap: true, children: widget.children),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.black),
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.all(Colors.transparent)),
        focusNode: _focusNode,
        onPressed: () {
          if (!isMenuOpen) {
            _focusNode.requestFocus();
          } else {
            _focusNode.unfocus();
          }
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                widget.child,
                const SizedBox(
                  width: 8,
                ),
                AnimatedContainer(
                  transform: (isMenuOpen) ? Matrix4.rotationX(3.14) : Matrix4.rotationX(0),
                  transformAlignment: Alignment.center,
                  duration: const Duration(milliseconds: 600),
                  child: const Icon(Icons.keyboard_arrow_down),
                )
              ],
            )));
  }
}
