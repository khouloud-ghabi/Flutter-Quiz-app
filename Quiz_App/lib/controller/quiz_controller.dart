import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/model/question.dart';
import 'package:quiz_app/view/result_screen.dart';
import 'package:quiz_app/view/welcome_screen.dart';

class QuizController extends GetxController {
  String name = '';
  final List<QuestionModel> _questionList = [
    QuestionModel(
      id: 1,
      question: "How many types of widgets are there in Flutter?",
      answer: 1,
      options: [
        '2',
        '4',
        '6',
        '8+'
      ],
    ),
    QuestionModel(
      id: 2,
      question: "A sequence of asynchronous Flutter events is known as a: ",
      answer: 3,
      options: ['Flow', 'Current', 'Stream', 'Series'],
    ),
    QuestionModel(
      id: 3,
      question: "What element is used as an identifier for components when programming in Flutter?",
      answer: 2,
      options: ['Widgets', 'Keys', ' Elements', 'Serial'],
    ),
    QuestionModel(
      id: 4,
      question: "Which function will return the widgets attached to the screen as a root of the widget tree to be rendered on screen?",
      answer: 1,
      options: ['main()', ' runApp()', 'container()', 'root()'],
    ),
    QuestionModel(
      id: 5,
      question: "What is the key configuration file used when building a Flutter project?",
      answer: 1,
      options: ['pubspec.yaml', 'pubspec.xml', 'config.html', 'All of the above'],
    ),
    QuestionModel(
      id: 6,
      question: "Which release mode will not contain any debugging data when run?",
      answer: 3,
      options: ['Profile', ' Debug', 'Release', 'Test'],
    ),
    QuestionModel(
      id: 7,
      question: "What language is Flutter's rendering engine primarily written in?",
      answer: 2,
      options: ['Kotlin', 'C++', 'Dart', 'Java'],
    ),
    QuestionModel(
      id: 8,
      question: "What widget would you use for repeating content in Flutter?",
      answer: 2,
      options: ['ExpandedView', 'ListView', 'Stack', 'ArrayView'],
    ),
    QuestionModel(
      id: 9,
      question: "Which component allows us to specify the distance between widgets on the screen?",
      answer: 2,
      options: [
        'SafeArea',
        'SizedBox',
        'table',
        'AppBar '
      ],
    ),
    QuestionModel(
      id: 10,
      question: "Best State Mangment Ststem is ",
      answer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
    ),
  ];

  bool _isPressed = false;
  double _QuestionNumber = 1;
  int? _selectedAnswer;
  int _countCorrectAnswer = 0;
  final RxInt _secnd = 30.obs;

  int get countQuestion => _questionList.length;

  List<QuestionModel> get questionList => [..._questionList];
  bool get isPressed => _isPressed;

  double get QuestionNumber => _QuestionNumber;

  int? get selectedAnswer => _selectedAnswer;

  int get countCorrectAnswer => _countCorrectAnswer;

  RxInt get secnd => this._secnd;

  int? _correctAnswer;
  final Map<int, bool> __questionIsAnswer = {};
  Timer? _timer;
  final maxSecnd = 30;
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    resetAnswer();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  //get final score
  double get scoreResult {
    return countCorrectAnswer * 100 / _questionList.length;
  }

  void checkAnswer(QuestionModel questionModel, int selectAnswer) {
    _isPressed = true;

    _selectedAnswer = selectAnswer;
    _correctAnswer = questionModel.answer;

    if (_correctAnswer == _selectedAnswer) {
      _countCorrectAnswer++;
    }
    stopTimer();
    __questionIsAnswer.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => nextQuestion());
    update();
  }

  //check if the question has been answered
  bool checkIsQuestionAnswered(int quesId) {
    return __questionIsAnswer.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }

  void nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }

    if (pageController.page == _questionList.length - 1) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);

      startTimer();
    }
    _QuestionNumber = pageController.page! + 2;
    update();
  }

  //called when start again quiz
  void resetAnswer() {
    for (var element in _questionList) {
      __questionIsAnswer.addAll({element.id: false});
    }
    update();
  }

  //get right and wrong color
  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green.shade700;
      } else if (answerIndex == _selectedAnswer &&
          _correctAnswer != _selectedAnswer) {
        return Colors.red.shade700;
      }
    }
    return Colors.white;
  }

  //het right and wrong icon
  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == _selectedAnswer &&
          _correctAnswer != _selectedAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secnd.value > 0) {
        _secnd.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }

  void resetTimer() => _secnd.value = maxSecnd;

  void stopTimer() => _timer!.cancel();
  //call when start again quiz
  void startAgain() {
    _correctAnswer = null;
    _countCorrectAnswer = 0;
    resetAnswer();
    _selectedAnswer = null;
    Get.offAllNamed(WelcomeScreen.routeName);
  }
}

class _questionsList {}
