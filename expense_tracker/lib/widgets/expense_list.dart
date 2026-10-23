import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';

class ExpenseList extends StatelessWidget {
  final void Function(ExpenseModel expense) onRemoveExpense;
  final List<ExpenseModel> expenses;
  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        final expenseModel = expenses[index];
        return Dismissible(
          key: ValueKey(expenseModel.id),
          background: Container(
            margin: Theme.of(context).cardTheme.margin ??
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onDismissed: (direction) {
            onRemoveExpense(expenseModel);
          },
          child: ExpenseItem(expenseModel: expenseModel),
        );
      },
    );
  }
}
