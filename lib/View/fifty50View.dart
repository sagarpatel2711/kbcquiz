import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kbcquiz/Controller/questionController.dart';
import 'package:kbcquiz/Themes/customTextStyle.dart';

import '../Themes/appColors.dart';

class Fifty50View extends StatelessWidget {
  Fifty50View({super.key});

  List wrongOpt = [];
  QuestionController questionController = Get.put(QuestionController());
  fetchWrongOpt() {
    var question = questionController.questionResponceModel;
    if (question.option1 != question.correctAnswer) {
      wrongOpt.add(question.option1);
    }
    if (question.option2 != question.correctAnswer) {
      wrongOpt.add(question.option2);
    }
    if (question.option3 != question.correctAnswer) {
      wrongOpt.add(question.option3);
    }
    if (question.option4 != question.correctAnswer) {
      wrongOpt.add(question.option4);
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchWrongOpt();
    Future.delayed(Duration(seconds: 10), () {
      Get.back();
    });
    return Scaffold(
      backgroundColor: AppColors.purpleColor,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.purpleAccentColor,
              borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 200),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "FIFTY 50 LIFELINE",
                style: CustomTextStyle.text1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${wrongOpt[0]} AND ${wrongOpt[1]}  IS INCORRECT OPTIONS",
                style: CustomTextStyle.text3,
                textAlign: TextAlign.center,
              ),
              const Text(
                "You Will Be Automatically Redirected To Quiz Screen In 10 Seconds.",
                style: CustomTextStyle.text3,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
