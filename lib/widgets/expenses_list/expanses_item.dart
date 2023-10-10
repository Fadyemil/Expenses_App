import 'package:expenses/models/expenses.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.Expense});

  final ExpensesModels Expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(
              Expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '\$${Expense.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[Expense.category]),
                    const SizedBox(width: 8),
                    Text(Expense.FormattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
