import 'package:expenses/chart/chart.dart';
import 'package:expenses/models/input.dart';
import 'package:flutter/material.dart';
import './models/expense.dart';
import './models/expense_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> a = [
    ExpenseModel(
        title: 'Burger',
        amount: 69.69,
        date: DateTime.now(),
        category: Category.food),
    ExpenseModel(
        title: 'Travel',
        amount: 93.93,
        date: DateTime.now(),
        category: Category.travel),
  ];
  void addNewExpense(ExpenseModel newExpense) {
    setState(() {
      a.add(newExpense);
    });
  }

  void removeExpense(ExpenseModel expense) {
    int idx = a.indexOf(expense);
    setState(() {
      a.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                a.insert(idx, expense);
              });
            }),
      ),
    );
  }

  void modalsheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Input(
            func: addNewExpense,
          );
        });
  }

  @override
  Widget build(context) {
    Widget mainContent = const Center(
      child: Text('No Expenses , Start adding some !'),
    );
    if (a.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: a,
        a: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracker'), actions: [
        IconButton(onPressed: modalsheet, icon: const Icon(Icons.add)),
      ]),
      body:
          Column(children: [const Text('Chart'),Chart(expenses: a),Expanded(child: mainContent)]),
    );
  }
}

