import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseListModel extends StatelessWidget {
  const ExpenseListModel({super.key, required this.expense});
  final ExpenseModel expense;
  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(expense.title,style: Theme.of(context).textTheme.titleLarge,),
          const SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('\$${expense.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(
                children: [
                  Icon(icons[expense.category]),
                  const SizedBox(width: 8,),
                  Text(expense.formattedDate),
                  
                ],
              )
             
            ],
          )
        ],)
      ),
    );
  }
}
