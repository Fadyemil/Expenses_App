import 'package:expenses/models/expenses.dart';
import 'package:expenses/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<ExpensesModels> expenses;

  List<ExpenseBuket> get buckets {
    return [
      ExpenseBuket.forCategory(expenses, Category.food),
      ExpenseBuket.forCategory(expenses, Category.leisure),
      ExpenseBuket.forCategory(expenses, Category.travel),
      ExpenseBuket.forCategory(expenses, Category.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (var element in buckets) {
      if (element.totleExpenses > maxTotalExpense) {
        maxTotalExpense = element.totleExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          width: double.infinity,
          height: constraint.minHeight * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
                Theme.of(context).colorScheme.primary.withOpacity(0.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final ele in buckets)
                      ChartBar(
                        fill: ele.totleExpenses == 0
                            ? 0
                            : ele.totleExpenses / maxTotalExpense,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: buckets
                    .map(
                      (e) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Icon(
                            categoryIcons[e.category],
                            color: isDarkMode
                                ? Theme.of(context)
                                    .colorScheme
                                    .onTertiary
                                    .withOpacity(0.7)
                                : Theme.of(context).colorScheme.primary,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
