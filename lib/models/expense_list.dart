import 'package:flutter/material.dart';
import './expense.dart';
import '../widgets/expenses_list_model.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses, required this.a});
  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel a) a;
  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              key: ValueKey(expenses[index]),
              background: Container(color: Theme.of(context).colorScheme.error,),
              onDismissed: (_) {
                a(expenses[index]);
              },
              child: ExpenseListModel(
                expense: expenses[index],
              ));
        });
  }
}
