import 'package:flutter/material.dart';

import '../models/expense_model.dart';

class NewExpense extends StatefulWidget {
  final void Function(ExpenseModel expense) onAddExpense;
  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController amountCtrl = TextEditingController();
  Category _selectedCategory = Category.work;
  DateTime? _selectedDate;

  Future<void> _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: firstDate,
      lastDate: now,
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    amountCtrl.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(amountCtrl.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (titleCtrl.text.trim().isEmpty || amountIsInvalid || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Invalid Input"),
            content: const Text(
              "Please make sure a valid title, amount, date and category was entered.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    final expense = ExpenseModel(
      title: titleCtrl.text.trim(),
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    );

    widget.onAddExpense(expense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: keyboardSpace + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              maxLength: 50,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.label_outlined),
                hintText: "Title",
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: amountCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(prefixText: '\$ ', hintText: "Amount"),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _selectedDate == null
                            ? "No date selected"
                            : "${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}",
                      ),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                DropdownButton<Category>(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _submitExpenseData, child: const Text("Save")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
