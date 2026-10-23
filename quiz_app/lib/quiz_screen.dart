import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/widgets/answer_button.dart';

class QuizScreen extends StatefulWidget {
  final void Function(String answer) onSelectAnswer;

  const QuizScreen({super.key, required this.onSelectAnswer});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIdx = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIdx++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = Questions.questions[currentQuestionIdx];
    return Scaffold(
      body: Container(
        height: double.infinity,
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...currentQuestion.shuffledAnswers.map((e) {
              return AnswerButton(
                answerText: e,
                onPressed: () {
                  answerQuestion(e);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
