import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/quiz_controller.dart';
import 'package:quiz_app/view/quiz_screen.dart';
import 'package:quiz_app/widget/custom_button.dart';

import '../constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const routeName = '/welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _nameController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey();

  void _submit(context) {
    FocusScope.of(context).unfocus();
    if (!_formkey.currentState!.validate()) return;
    _formkey.currentState!.save();
    Get.offAndToNamed(QuizScreen.routeName);
    Get.find<QuizController>().startTimer();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/sui.png'), fit: BoxFit.cover),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(screenSize.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenSize.height * 0.2),
                    Text('Let\'s start Quiz,',
                        style: TextStyle(
                            color: KPrimaryColor,
                            fontSize: screenSize.width * 0.05)),
                    Text(
                      'Enter your name to start',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Color.fromARGB(255, 7, 117, 212),
                          fontSize: screenSize.width * 0.04),
                    ),
                    SizedBox(height: screenSize.height * 0.05),
                    Form(
                      key: _formkey,
                      child: GetBuilder<QuizController>(
                        init: Get.find<QuizController>(),
                        builder: (controller) => TextFormField(
                          controller: _nameController,
                          style: TextStyle(
                              color: Color.fromARGB(255, 27, 9, 190),
                              fontSize: screenSize.width * 0.04),
                          decoration: InputDecoration(
                              labelText: 'Full Name',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 146, 147, 151),
                                  fontSize: screenSize.width * 0.04),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(screenSize.width * 0.04)))),
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return 'Name should not be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (String? val) {
                            controller.name = val!.trim().toUpperCase();
                          },
                          onFieldSubmitted: (_) => _submit(context),
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.05),
                    Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                        width: double.infinity,
                        onPressed: () => _submit(context),
                        text: 'Lets Start Quiz',
                        fontSize: screenSize.width * 0.04,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.2),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
