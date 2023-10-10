import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/data/questions.dart';
import 'package:quiz/questions_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key,
      required this.chosenAnswers,
      required this.onRestart,
      required this.onExit});

  final List<String> chosenAnswers;
  final void Function() onRestart;
  final void Function() onExit;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
              // TextButton.icon(
              //   onPressed: onRestart,
              //   style: TextButton.styleFrom(
              //     foregroundColor: Colors.white,
              //   ),
              //   icon: const Icon(Icons.refresh),
              //   label: const Text(
              //       style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
              //       'Restart Quiz'),
              // ),

            //   const SizedBox(
            //     width: 60,
            //   ),

              // TextButton.icon(
              //   onPressed: onExit,
              //   style: TextButton.styleFrom(
              //     foregroundColor: Colors.white,
              //   ),
              //   icon: const Icon(Icons.exit_to_app),
              //   label: const Text(
              //       style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
              //       'Exit'),
              // ),
            // )

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                onPressed: onRestart,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.refresh),
                label: const Text(
                    style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                    'Restart Quiz'),
              ),

                const SizedBox(
                  width: 60,
                ),

                TextButton.icon(
                onPressed: onExit,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.exit_to_app),
                label: const Text(
                    style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                    'Exit'),
              ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
