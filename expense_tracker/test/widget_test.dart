import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Expense tracker loads and displays empty state and add action', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Verify AppBar title is displayed.
    expect(find.text('Expense Tracker'), findsOneWidget);

    // Verify empty state text is displayed.
    expect(find.text('No expense found. Start adding some!!'), findsOneWidget);

    // Verify Add button is present.
    expect(find.byIcon(Icons.add), findsWidgets);
  });
}
