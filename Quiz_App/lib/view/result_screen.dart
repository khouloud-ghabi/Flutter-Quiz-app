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
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 181, 223, 255),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: GetBuilder<QuizController>(
                init: Get.find<QuizController>(),
                builder: (controller) => SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Congratulation',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: const Color.fromARGB(255, 37, 3, 130),
                              fontSize: screenSize.width * 0.07,
                            ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      Text(
                        controller.name,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: KPrimaryColor,
                              fontSize: screenSize.width * 0.07,
                            ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      Text(
                        'Your Score is',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: const Color.fromARGB(255, 17, 219, 34),
                              fontSize: screenSize.width * 0.06,
                            ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      Text(
                        '${controller.scoreResult.round()} /100',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: KPrimaryColor,
                              fontSize: screenSize.width * 0.07,
                            ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.04,
                      ),
                      CustomButton(
                        onPressed: () => controller.startAgain(),
                        text: 'Start Again',
                        fontSize: screenSize.width * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
