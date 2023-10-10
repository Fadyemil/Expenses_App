import 'dart:ffi';

import 'package:expenses/models/expenses.dart';
import 'package:expenses/widgets/chart/chart.dart';
import 'package:expenses/widgets/expenses_list/expanses_list.dart';
import 'package:expenses/widgets/new_expenses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

bool _iconBool = true;

IconData _iconLight = Icons.wb_sunny;
IconData _iconDark = Icons.nights_stay;

class _ExpensesState extends State<Expenses> {
  final List<ExpensesModels> _registeredExpenses = [
    ExpensesModels(
      category: Category.work,
      title: 'Flutter Course',
      amount: 29.9,
      date: DateTime.now(),
    ),
    ExpensesModels(
      category: Category.leisure,
      title: 'Cinema',
      amount: 9.71,
      date: DateTime.now(),
    ),
    ExpensesModels(
      category: Category.food,
      title: 'Breakfast',
      amount: 31.3,
      date: DateTime.now(),
    ),
  ];

  void _addExpense(ExpensesModels expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(ExpensesModels expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  bool isDarkModeEnabled = false;
  void onStateChanged(bool isDarkModeEnabled) {
    setState(() {
      this.isDarkModeEnabled = isDarkModeEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Expens Tracker',
            style: TextStyle(fontSize: 23),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (con) => NewExpense(onAddExpense: _addExpense));
            },
            icon: const Icon(
              Icons.add,
              size: 35,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _iconBool = !_iconBool;
              });
            },
            icon: Icon(_iconBool ? _iconDark : _iconLight),
          )
        ],
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("LoginPage", (route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          );
        }),
      ),
      body: Center(
        child: width < 600
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(
                    child: ExpensesList(
                      onRemoveExpense: _removeExpense,
                      Expenses: _registeredExpenses,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(
                    child: ExpensesList(
                      onRemoveExpense: _removeExpense,
                      Expenses: _registeredExpenses,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
