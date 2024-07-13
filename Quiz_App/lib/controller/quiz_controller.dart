import 'package:get/get.dart';
import 'package:quiz_app/model/question.dart';

class QuizController extends GetxController {
  String name = '';
  final List<QuestionModel> _questionList = [
    QuestionModel(id:id ,answer: answer, question: question, options: options)
  ];
}
