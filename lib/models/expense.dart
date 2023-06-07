import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const icons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class ExpenseModel {
  ExpenseModel(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<ExpenseModel> expenselist;
  ExpenseBucket({required this.category, required this.expenselist});
  ExpenseBucket.forCategory(List<ExpenseModel> expenseList, this.category)
      : expenselist = expenseList
            .where((expense) => expense.category == category)
            .toList();
  double get totalexpense {
    double sum = 0;
    for (int i = 0; i < expenselist.length; i++) {
      sum += expenselist[i].amount;
    }
    return sum;
  }
}
