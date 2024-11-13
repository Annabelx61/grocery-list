import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/Grocery.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

typedef ToDoListChangedCallback = Function(Grocery grocery, bool completed, double price);
typedef ToDoListRemovedCallback = Function(Grocery grocery);

class ToDoListGrocery extends StatelessWidget {
  ToDoListGrocery(
      {required this.grocery,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteGrocery,
      required this.price})
      : super(key: ObjectKey(grocery));

  Grocery grocery;
  final bool completed;
  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteGrocery;
  final double price;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        print("tap");
        onListChanged(grocery, completed, price);
        
      },
      onLongPress: completed
          ? () {
            print("long");
              onDeleteGrocery(grocery);
            }
          : null,
      leading: CircleAvatar(
        child: Text(grocery.count.toString()),
      ),
      title: Text(
        grocery.name,
      ),
    );
  }
}
