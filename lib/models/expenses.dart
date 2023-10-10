import 'package:expenses/widgets/expanses.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormat = DateFormat.yMEd();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class ExpensesModels {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get FormattedDate {
    return dateFormat.format(date);
  }

  ExpensesModels({
    required this.category,
    required this.title,
    required this.amount,
    required this.date,
  }) : id = uuid.v4();
}

class ExpenseBuket {
  final Category category;
  final List<ExpensesModels> Expenses;

  ExpenseBuket(this.category, this.Expenses);
  ExpenseBuket.forCategory(List<ExpensesModels> allExpenses,this.category)
      : Expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

  double sum = 0;

  double get totleExpenses {
    for (var element in Expenses) {
      sum += element.amount;
    }
    return sum;
  }
}
