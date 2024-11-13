import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_dont_list/main.dart';

import 'package:to_dont_list/objects/Grocery.dart';
import 'package:to_dont_list/widgets/to_do_grocery.dart';

void main() {
  test('The first Grocery should should show 1 in circle avatar', () {
    Grocery grocery = Grocery(name: 'eggs', price: 10.99);
    expect(grocery.count, 1);
  });

  testWidgets('ToDoListGrocery has a text', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ToDoListGrocery(
                grocery: Grocery(name: "test", price: 10.99),
                price: 10.99,
                completed: true,
                onListChanged: (Grocery grocery, bool completed, double price) {},
                onDeleteGrocery: (Grocery grocery) {}))));
    final textFinder = find.text('test');
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Default ToDoList should not expect anything on display', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    final listGroceryFinder = find.byType(ToDoListGrocery);

    expect(listGroceryFinder, findsNothing);
  });
}
