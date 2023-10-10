import 'package:expenses/models/expenses.dart';
import 'package:expenses/widgets/expenses_list/expanses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.Expenses,
    required this.onRemoveExpense,
  });

  final List<ExpensesModels> Expenses;

  final void Function(ExpensesModels expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Expenses.length,
      itemBuilder: (context, i) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.7),
          margin: Theme.of(context).cardTheme.margin,
        ),
        key: ValueKey(Expenses[i]),
        onDismissed: (direction) => onRemoveExpense(Expenses[i]),
        child: ExpensesItem(
          Expense: Expenses[i],
        ),
      ),
    );
  }
}
