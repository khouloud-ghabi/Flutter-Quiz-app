import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/quiz_controller.dart';
import 'package:quiz_app/widget/custom_button.dart';

import '../../constants.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);
  static const routeName = '/result_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Color.fromARGB(255, 181, 223, 255),
        ),
        Center(
          child: GetBuilder<QuizController>(
            init: Get.find<QuizController>(),
            builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Congratulation',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Color.fromARGB(255, 37, 3, 130),
                      ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  controller.name,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: KPrimaryColor,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Your Score is',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Color.fromARGB(255, 17, 219, 34),
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  '${controller.scoreResult.round()} /100',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: KPrimaryColor,
                      ),
                ),
                const SizedBox(
                  height: 40,
            
                ),
                CustomButton(
                    onPressed: () => controller.startAgain(),
                    text: 'Start Again'),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
