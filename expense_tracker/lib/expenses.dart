import 'package:expense_tracker/widgets/charts/chart.dart';
import 'package:expense_tracker/widgets/expense_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import 'models/expense_model.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> _registeredExpenses = [];

  void _openAddExpenseOverly() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: addExpense),
    );
  }

  void addExpense(ExpenseModel expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(ExpenseModel expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
        content: const Text("Expense deleted!"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(child: Text("No expense found. Start adding some!!"));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(expenses: _registeredExpenses, onRemoveExpense: removeExpense);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Expense Tracker")),
      body: width < 600
          ? Column(
              children: [
                Chart(expense: _registeredExpenses),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expense: _registeredExpenses)),
                Expanded(child: mainContent),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Expense",
        onPressed: _openAddExpenseOverly,
        child: const Icon(Icons.add),
      ),
    );
  }
}
