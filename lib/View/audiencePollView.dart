import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kbcquiz/Controller/questionController.dart';
import 'package:kbcquiz/Themes/appColors.dart';
import 'package:kbcquiz/Themes/customTextStyle.dart';

class AudiencePollView extends StatelessWidget {
  AudiencePollView({super.key});
  QuestionController questionController = Get.put(QuestionController());

  RxInt opt1Votes = 0.obs;
  RxInt opt2Votes = 0.obs;
  RxInt opt3Votes = 0.obs;
  RxInt opt4Votes = 0.obs;
  RxBool isVoting = false.obs;

  votingMachine() async {
    isVoting.value = true;
    await Future.delayed(Duration(seconds: 5), () {
      var questionModal = questionController.questionResponceModel;
      if (questionModal.option1 == questionModal.correctAnswer) {
        opt1Votes.value = Random().nextInt(100);
      } else {
        opt1Votes.value = Random().nextInt(40);
      }

      if (questionModal.option2 == questionModal.correctAnswer) {
        opt2Votes.value = Random().nextInt(100);
      } else {
        opt2Votes.value = Random().nextInt(40);
      }
      if (questionModal.option3 == questionModal.correctAnswer) {
        opt3Votes.value = Random().nextInt(100);
      } else {
        opt3Votes.value = Random().nextInt(40);
      }
      if (questionModal.option4 == questionModal.correctAnswer) {
        opt4Votes.value = Random().nextInt(100);
      } else {
        opt4Votes.value = Random().nextInt(40);
      }
    });
    isVoting.value = false;
  }

  @override
  Widget build(BuildContext context) {
    votingMachine();
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.purpleAccentColor,
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Audience Poll Lifeline",
                  style: CustomTextStyle.text1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                    "Question  - ${questionController.questionResponceModel.question}",
                    style: CustomTextStyle.text1,
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 10,
                ),
                Text(
                  isVoting.value
                      ? "Audience is Voting"
                      : "Here are the Results",
                  style: CustomTextStyle.text1,
                ),
                SizedBox(
                  height: 10,
                ),
                textWidget(
                    "${questionController.questionResponceModel.option1}\t\t$opt1Votes Votes"),
                const SizedBox(
                  height: 3,
                ),
                textWidget(
                    "${questionController.questionResponceModel.option2}\t\t$opt2Votes Votes"),
                const SizedBox(
                  height: 3,
                ),
                textWidget(
                    "${questionController.questionResponceModel.option3}\t\t$opt3Votes Votes"),
                const SizedBox(
                  height: 3,
                ),
                textWidget(
                    "${questionController.questionResponceModel.option4}\t\t$opt4Votes Votes"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  textWidget(String title) {
    return Text(title,
        style: CustomTextStyle.text3, textAlign: TextAlign.center);
  }
}
