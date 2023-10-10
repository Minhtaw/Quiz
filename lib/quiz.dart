import 'package:flutter/material.dart';
import 'package:quiz/data/questions.dart';
import 'package:quiz/questions_screen.dart';
import 'package:quiz/results_screen.dart';
import 'package:quiz/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];

  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length){
      setState(() {
        // selectedAnswers = [];
        activeScreen = 'results-screen';
      });
    }
  }

  void RestartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'question-screen';
    });
  }

  void ExitQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(context) {

    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'question-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget =  ResultsScreen(
        chosenAnswers: selectedAnswers,
        onRestart: RestartQuiz,
        onExit: ExitQuiz,
      );
    }

    // final screenWidget = activeScreen == 'start-screen'
    //   ? StartScreen(switchScreen)
    //   : const QuestionsScreen();

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 252, 175, 161),
                Color.fromARGB(255, 2, 0, 12)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
          // Ternary Operators
          // child: activeScreen == 'start-screen'
          //     ?StartScreen(switchScreen)
          //     : const QuestionsScreen(),
        ),
      ),
    );
  }
}