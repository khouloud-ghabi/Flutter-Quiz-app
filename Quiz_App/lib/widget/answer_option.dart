import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/quiz_controller.dart';

class AnswerOption extends StatelessWidget {
  String text;
  int index, questionID;
  Function() onPressed;

  AnswerOption(
      {required this.text,
      required this.index,
      required this.questionID,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GetBuilder <QuizController>(
      init: QuizController(),
      builder: (controller) => InkWell(
        onTap: controller.checkIsQuestionAnswered(questionID)? null:onPressed,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
          border:  Border.all(width: 3, color: controller.getColor(index))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                        text: '${index + 1}. ',
                        style: Theme.of(context).textTheme.headline6,
                        children: [
                          TextSpan(
                            text: text,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ]),
                  ),
                  if (controller.checkIsQuestionAnswered(questionID) &&
                      controller.selectedAnswer == index)
                    Container(
                        width: 30,
                        height: 30,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: controller.getColor(index),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            shape: BoxShape.circle),
                        child: Icon(
                          controller.getIcon(index),
                          color: Colors.white,
                        ))
                ],
              ),
            ),
          )),
    );
  }
}