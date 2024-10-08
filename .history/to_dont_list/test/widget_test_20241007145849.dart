// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/objects/toy.dart';
import 'package:to_dont_list/widgets/toy_items.dart';
import 'package:to_dont_list/widgets/toy_dialog.dart';

// test ideas: 

void main() {

  // Yes, you really need the MaterialApp and Scaffold
  testWidgets('ToyListItem has a text', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ToyListItem(
                toy: Toy(name: "test", color: SideColor.a.rgbcolor),
                got: true,
                onListChanged: (Toy item, bool got) {},
                onDeleteItem: (Toy item) {}))));
    final textFinder = find.text('test');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(textFinder, findsOneWidget);
  });

  testWidgets('ToyItem has a Circle Avatar with a color to match',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ToyListItem(
                toy: Toy(name: "test", color: SideColor.o.rgbcolor),
                got: false,
                onListChanged: (Toy item, bool got) {},
                onDeleteItem: (Toy item) {}))));
    final avatarFinder = find.byType(CircleAvatar);

    CircleAvatar circ = tester.firstWidget(avatarFinder);

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(circ.backgroundColor, SideColor.o.rgbcolor);
  });

  testWidgets('Default ToyList has one item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToyList()));

    final listItemFinder = find.byType(ToyListItem);

    expect(listItemFinder, findsOneWidget);
  });

  testWidgets('Default toy Faction is Autobot', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToyList()));
    final avatarFinder = find.byType(CircleAvatar);
    CircleAvatar circ = tester.firstWidget(avatarFinder);
    expect(circ.backgroundColor, SideColor.a.rgbcolor); 
  });

  testWidgets('ToyDialog has a DropDownMenu', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToyList()));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    final DropDownFinder = find.byType(DropDownMenu<SideColor>());
    expect(DropDownFinder, findsOneWidget);
  });

  // testWidgets('Clicking and Typing adds item to ToyList', (tester) async {
  //   await tester.pumpWidget(const MaterialApp(home: ToyList()));

  //   expect(find.byType(TextField), findsNothing);

  //   await tester.tap(find.byType(FloatingActionButton));
  //   await tester.pump(); // Pump after every action to rebuild the widgets
  //   expect(find.text("hi"), findsNothing);

  //   await tester.enterText(find.byType(TextField), 'hi');
  //   await tester.pump();
  //   expect(find.text("hi"), findsOneWidget);

  //   await tester.tap(find.byKey(const Key("OKButton")));
  //   await tester.pump();
  //   expect(find.text("hi"), findsOneWidget);

  //   final listItemFinder = find.byType(ToyListItem);

  //   expect(listItemFinder, findsNWidgets(2));
  // });

  // One to test the tap and press actions on the items?
}