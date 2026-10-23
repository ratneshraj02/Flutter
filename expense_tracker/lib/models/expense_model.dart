import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcon = {
  Category.food: Icons.lunch_dining_outlined,
  Category.travel: Icons.flight_takeoff_outlined,
  Category.leisure: Icons.movie_creation_outlined,
  Category.work: Icons.work_outline,
};

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get getFormateDate =>
      '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
}

class ExpenseBucket {
  final Category category;
  final List<ExpenseModel> expenses;

  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<ExpenseModel> allExpense, this.category)
      : expenses =
            allExpense.where((expense) => expense.category == category).toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
