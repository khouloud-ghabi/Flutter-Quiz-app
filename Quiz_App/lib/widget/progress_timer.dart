import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/quiz_controller.dart';

import '../constants.dart';

class ProgressTimer extends StatelessWidget {
  ProgressTimer({Key? key}) : super(key: key);
  final controller = Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - (controller.secnd.value / 30),
              color: Color.fromARGB(255, 8, 22, 141),
              backgroundColor: Color.fromARGB(255, 203, 222, 254),
              strokeWidth: 8,
            ),
            Center(
              child: Text(
                '${controller.secnd.value}',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Color.fromARGB(255, 8, 22, 141),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
