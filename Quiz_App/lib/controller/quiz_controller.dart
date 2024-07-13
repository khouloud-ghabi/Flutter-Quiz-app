import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/model/question.dart';

class QuizController extends GetxController {
  String name = '';
  final List<QuestionModel> _questionList = [
    QuestionModel(
      id: 1,
      question: "Best Channel for Flutter ",
      answer: 2,
      options: [
        'Sec it',
        'Sec it developer',
        'sec it developers',
        'mesh sec it '
      ],
    ),
    QuestionModel(
      id: 2,
      question: "Best State Mangment Ststem is ",
      answer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
    ),
    QuestionModel(
      id: 3,
      question: "Best Flutter dev",
      answer: 2,
      options: ['sherif', 'sherif ahmed', 'ahmed sherif', 'doc sherif'],
    ),
    QuestionModel(
      id: 4,
      question: "Sherif is",
      answer: 1,
      options: ['eng', 'Doc', 'eng/Doc', 'Doc/Eng'],
    ),
    QuestionModel(
      id: 5,
      question: "Best Rapper in Egypt",
      answer: 3,
      options: ['Eljoker', 'Abyu', 'R3', 'All of the above'],
    ),
    QuestionModel(
      id: 6,
      question: "Real Name of ahmed sherif",
      answer: 2,
      options: ['ahmed sherif', 'sherif', 'Haytham', 'NONE OF ABOVE'],
    ),
    QuestionModel(
      id: 7,
      question: "Sherif love",
      answer: 3,
      options: ['Pharma', 'Micro', 'Medicnal', 'NONE OF ABOVE'],
    ),
    QuestionModel(
      id: 8,
      question: "hello",
      answer: 3,
      options: ['hello', 'hi', 'hola', 'Suiiiiiiiiiiii'],
    ),
    QuestionModel(
      id: 9,
      question: "Best Channel for Flutter ",
      answer: 2,
      options: [
        'Sec it',
        'Sec it developer',
        'sec it developers',
        'mesh sec it '
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
    resetAnswer();

    super.onClose();
  }

  double get scoreResult {
    return countCorrectAnswer * 100 / _questionList.length;
  }

  void checkAnswer(QuestionModel questioModel, int selectedAnswer) {
    _isPressed = true;
    _selectedAnswer = _selectedAnswer;
    _correctAnswer = questioModel.answer;
    if (_correctAnswer == _selectedAnswer) {
      _countCorrectAnswer++;
    }
    stopTimer();

    __questionIsAnswer.update(questioModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500))
        .then((Value) => nextQuestion());

    update();
  }

  bool chekIsQuestionAnswer(int quesID) {
    return __questionIsAnswer.entries
        .firstWhere((element) => element.key == quesID)
        .value;
  }

  void resetAnswer() {
    for (var element in _questionList) {
      __questionIsAnswer.addAll({element.id: false});
    }
    update();
  }

  getColor(int ansmerIndex) {
    if (_isPressed) {
      if (ansmerIndex == _correctAnswer) {
        return Icons.done;
      } else if (ansmerIndex == _selectedAnswer &&
          _correctAnswer != _selectedAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }

  nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }
    if (pageController.page == _questionList.length - 1) {
      //todo navigation result screen.....
    } else {
      _isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
      startTimer();
    }
    _QuestionNumber = pageController.page! + 2;
    update();
  }

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secnd.value > 0) {
        -secnd.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }

  void startAgain() {
    _correctAnswer = null;
    _countCorrectAnswer = 0;
    _selectedAnswer = null;
    resetAnswer();
    //todo navigation to welcom screen....
  }

  void stopTimer() => _timer!.cancel();

  void resetTimer() => _secnd.value = maxSecnd;

  bool checkIsQuestionAnswered(int quesId) {
    return __questionIsAnswer.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }
}
