// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mapnpospoc/main.dart';
import 'package:mapnpospoc/views/user.view.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
  testWidgets('Does tapping User from sidemenu show up the User screen', (WidgetTester tester) async {
    //Arrange
    await tester.pumpWidget(const MainApp());
    final userPageButton = find.widgetWithText(MaterialButton, "Users");
    final addUserButton = find.byWidget(const AddUser());
    //Act
    await tester.tap(userPageButton);
    //Assert
    expect(addUserButton, findsOneWidget);
  });
  // testWidgets('Does add user button change the position of user form to centerish of screen', (WidgetTester tester) async {
  //   //Arrange
  //   await tester.pumpWidget(const MainApp());
  //   final userPageButton
  //   //Act
  //   //Assert
  // });
}
