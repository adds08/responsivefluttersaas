import 'package:flutter/material.dart';

class ErrorLoading extends StatelessWidget {
  final VoidCallback onClick;

  const ErrorLoading({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Column(
          children: [
            const Text(
              "Oops",
              style: TextStyle(fontSize: 100, fontWeight: FontWeight.w700),
            ),
            const Text(
              "An Error Has Occurred!",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
            ),
            TextButton(
              child: Row(
                children: const [Icon(Icons.refresh), Text("Refresh")],
              ),
              onPressed: onClick,
            ),
          ],
        ),
      ),
    );
  }
}
