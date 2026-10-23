import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/icon_text.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final ExpenseModel expenseModel;
  const ExpenseItem({super.key, required this.expenseModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconText2(
              text: expenseModel.title,
              iconData:
                  categoryIcon[expenseModel.category] ?? Icons.category_outlined,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconText(
                  text: expenseModel.amount.toStringAsFixed(2),
                  iconData: Icons.currency_rupee,
                ),
                IconText(
                  text: expenseModel.getFormateDate,
                  iconData: Icons.date_range,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
