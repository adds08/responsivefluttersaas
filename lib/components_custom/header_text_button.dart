import 'package:flutter/material.dart';

class HeaderTextButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  const HeaderTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.icon,
  }) : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextButton(
        key: key,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (icon == null) ? Container() : Icon(icon),
              const SizedBox(
                width: 6,
              ),
              Text(text)
            ],
          ),
        ),
      ),
    );
  }

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    // TODO: implement defaultStyleOf
    throw UnimplementedError();
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    // TODO: implement themeStyleOf
    throw UnimplementedError();
  }
}
