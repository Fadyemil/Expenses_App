import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expenses/widgets/expanses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expenses.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(ExpensesModels expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titlController = TextEditingController();
  final _amountController = TextEditingController();

  final formatter = DateFormat.yMEd();
  DateTime? _selectedDate;

  Category _selectedCategory = Category.travel;

  @override
  void dispose() {
    super.dispose();
    _titlController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _titlController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(_selectedDate == null
                              ? 'No Date Selsct Date'
                              : formatter.format(_selectedDate!)),
                        ),
                        IconButton(
                          onPressed: () async {
                            final now = DateTime.now();
                            final firstDate =
                                DateTime(now.year - 1, now.month, now.day);
                            final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: now,
                                firstDate: firstDate,
                                lastDate: now);
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          },
                          icon: const Icon(Icons.calendar_today),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (newCat) {
                      if (newCat == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = newCat;
                      });
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Background color
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Background color
                    ),
                    onPressed: () {
                      final double? entereAmount =
                          double.tryParse(_amountController.text);
                      final bool amountIsInvalid =
                          entereAmount == null || entereAmount <= 0;
                      if (_titlController.text.trim().isEmpty ||
                          amountIsInvalid ||
                          _selectedDate == null) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Make sure to enter all data',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      } else {
                        widget.onAddExpense(
                          ExpensesModels(
                            title: _titlController.text,
                            amount: entereAmount,
                            date: _selectedDate!,
                            category: _selectedCategory,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      "save Expense",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
