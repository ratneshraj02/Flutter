import 'package:flutter/material.dart';
import 'package:quiz_app/question_summary.dart';

import 'data/questions.dart';

class ResultScreen extends StatelessWidget {
  final List<String> chosenAnswer;

  const ResultScreen({super.key, required this.chosenAnswer});

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i <= chosenAnswer.length; i++) {
      summary.add({
        'question-index': i,
        'question': Questions.questions[i].text,
        'correct-answer': Questions.questions[i].answer[0],
        'user-answer': chosenAnswer[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numberOfTotalQuestion = Questions.questions.length;
    final numberOfCorrectQuestion = summaryData.where((ele) {
      return ele['user-answer'] == ele['correct-answer'];
    }).length;

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Your answer $numberOfCorrectQuestion out of $numberOfTotalQuestion correctly"),
              const SizedBox(height: 20),
              QuestionSummary(summaryData),
              const SizedBox(height: 20),
              TextButton(onPressed: () {}, child: const Text("Restart Quiz!")),
            ],
          ),
        ),
      ),
    );
  }
}
