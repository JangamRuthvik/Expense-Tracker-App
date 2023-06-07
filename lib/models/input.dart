import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './expense.dart';

class Input extends StatefulWidget {
  Input({super.key, required this.func});
  final void Function(ExpenseModel a) func;
  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  var enteredTitle = TextEditingController();
  var enteredAmount = TextEditingController();
  Category selectedCategory = Category.leisure;
  DateTime? selectedDate;
  DateTime? pickedDate;
  final formatter = DateFormat.yMd();

  void datepicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void SubmitButton() {
    final a = double.tryParse(enteredAmount.text);
    bool isInvalid = a == null || a < 0;
    if (enteredTitle.text.trim().isEmpty || selectedDate == null || isInvalid) {
      //error
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Invalid Input'),
           content: const Text('Please Make Sure You Enter Valid Data'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Close'),
              )
            ],
          );
        },
      ); 
      return;
    }
    widget.func(ExpenseModel(
        title: enteredTitle.text,
        amount: double.parse(enteredAmount.text),
        date: selectedDate!,
        category: selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    enteredTitle.dispose();
    enteredAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,48,16,16),
      child: ListView(
        children: [
          Column(
            children: [
              TextField(
                controller: enteredTitle,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Title')),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: enteredAmount,
                      decoration: const InputDecoration(
                          prefixText: '\$ ', label: Text('Amount')),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(selectedDate == null
                          ? 'No Date Selected'
                          : formatter.format(selectedDate!)),
                      IconButton(
                          onPressed: datepicker,
                          icon: const Icon(Icons.calendar_month))
                    ],
                  )),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DropdownButton(
                      value: selectedCategory,
                      items: Category.values.map((category) {
                        return DropdownMenuItem(
                            value: category,
                            child:
                                Text(category.name.toString().toUpperCase()));
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          selectedCategory = value;
                        });
                      }),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: SubmitButton,
                      child: const Text('Save Expense')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
