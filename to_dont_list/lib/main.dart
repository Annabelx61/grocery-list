// Started with https://docs.flutter.dev/development/ui/widgets-intro
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/Grocery.dart';
import 'package:to_dont_list/widgets/to_do_grocery.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<Grocery> grocerys = [];
  final _groceryset = <Grocery>{};
  List<double> prices = [];



  void _handleListChanged(Grocery grocery, bool completed, double price) {
    setState(() {
      grocery.increase();
      // When a user changes what's in the list, you need
      // to change _groceryset inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      //grocerys.remove(grocery);
      //if (!completed) {
        //print("Completing");
        //_groceryset.add(grocery);
        //grocerys.add(grocery);
      //  print(grocerys);
      prices.add(price);
       // print(completed.toString());

      /*} else {
        print(completed.toString());
        print("Making Undone");
        _groceryset.remove(grocery);
      }*/
    });
  }

  void _handleDeleteGrocery(Grocery grocery) {
    setState(() {
      print("Deleting Grocery");
      grocerys.remove(grocery);
      prices.remove(grocery.price*grocery.count);
    });
  }

  void _handleNewGrocery(double price, String groceryText, TextEditingController textController, TextEditingController textController2) {
    setState(() {
      print("Adding new Grocery");
      Grocery grocery = Grocery(name: groceryText, price: price, count: 1);
      grocery.count;
      grocerys.insert(0, grocery);
      prices.add(price);
      textController.clear();
      textController2.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Grocery'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: grocerys.map((grocery) {
            return ToDoListGrocery(
              grocery: grocery,
              completed: _groceryset.contains(grocery),
              onListChanged: _handleListChanged,
              onDeleteGrocery: _handleDeleteGrocery,
              price: grocery.price,
            );
          }).toList(),
        ),
        floatingActionButton: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return ToDoDialog(onListAdded: _handleNewGrocery, 
                  onPricesAdded: (List<double> prices) {  },
                );
              }
            );
          },
        ),
        ElevatedButton(
          onPressed: () {
            double total = prices.reduce((a,b) => a + b);
            prices.reduce((a, b) => a + b);
            // https://stackoverflow.com/questions/10405348/what-is-the-cleanest-way-to-get-the-sum-of-numbers-in-a-collection-list-in-dart
            // -> to add the elementts of the list
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Total"),
                  content: Text("Your total is " + total.toString() ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close"),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text("Total"),
        ),
      ],
    ),
  );
}
}

void main() {
  runApp(const MaterialApp(
    title: 'Grossary List',
    home: ToDoList(),
  ));
}
