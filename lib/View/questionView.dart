import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kbcquiz/Controller/fireDBController.dart';
import 'package:kbcquiz/Controller/questionController.dart';
import 'package:kbcquiz/Localizations/imageAssets.dart';
import 'package:kbcquiz/Modal/questionResponceModal.dart';
import 'package:kbcquiz/Routes/pages.dart';
import 'package:kbcquiz/Themes/appColors.dart';
import 'package:kbcquiz/Themes/customTextStyle.dart';
import 'package:kbcquiz/Widgets/lifeLineDrawer.dart';

import '../Utilitys/logger.dart';

class QuestionView extends StatelessWidget {
  QuestionView({super.key});
  QuestionController questionController = Get.put(QuestionController());
  FireDBController fireDBController = Get.put(FireDBController());
  QuestionResponceModel questionResponceModel = QuestionResponceModel();
  RxBool isLoading = false.obs;
  RxBool optLockA = false.obs;
  RxBool optLockB = false.obs;
  RxBool optLockC = false.obs;
  RxBool optLockD = false.obs;

  queGen() async {
    isLoading.value = true;
    await fireDBController
        .genQuestions(
            fireDBController.listQuizzes[fireDBController.selectedCat.value]
                ['Quizid'],
            questionController.questionMoney.value)
        .then((questionData) {
      questionResponceModel.question = questionData['question'];
      questionResponceModel.correctAnswer = questionData['correctAnswer'];
      questionResponceModel.money = questionData['money'];
      List options = [
        questionData["opt1"],
        questionData["opt2"],
        questionData["opt3"],
        questionData["opt4"],
      ];
      options.shuffle();
      questionResponceModel.option1 = options[0];
      questionResponceModel.option2 = options[1];
      questionResponceModel.option3 = options[2];
      questionResponceModel.option4 = options[3];
    });

    isLoading.value = false;
  }

  Future<bool?> showWarning(
          {required BuildContext context,
          required String title,
          required String content}) async =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  title,
                  style: Get.textTheme.labelLarge,
                ),
                content: Text(content, style: Get.textTheme.labelMedium),
                actions: [
                  ElevatedButton(
                      onPressed: () => Get.back(), child: Text("no".tr)),
                  ElevatedButton(
                      onPressed: () async {
                        await fireDBController
                            .updateMoney(questionController.winerMoney.value);
                        Get.offAllNamed(Routes.homeView);
                      },
                      child: Text("okay".tr)),
                ],
              ));

  @override
  Widget build(BuildContext context) {
    queGen();
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(ImageAssets.bgImg))),
      child: WillPopScope(
        onWillPop: () async {
          final exitQuiz = await showWarning(
              context: context,
              title: "DO YOU WANT TO EXIT QUIZ ?",
              content:
                  "You Will Get Rs.${questionResponceModel.money == 5000 ? 0 : questionResponceModel.money / 2} In Your Account.");
          return exitQuiz ?? false;
        },
        child: Scaffold(
          onDrawerChanged: (isOpened) {},
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Obx(
              () => Text(
                isLoading.value ? "Rs." : "Rs. ${questionResponceModel.money}",
                style: CustomTextStyle.text1,
              ),
            ),
            centerTitle: true,
          ),
          drawer: LifeLineDrawer(),
          floatingActionButton: Obx(
            () => isLoading.value
                ? SizedBox()
                : ElevatedButton(
                    child: Text(
                      "quitgame".tr,
                      style: CustomTextStyle.text1,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  "wantquitgame".tr,
                                  style: Get.textTheme.displayLarge,
                                ),
                                content: Text(
                                  "getrsinacc".tr,
                                  style: Get.textTheme.labelMedium,
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        await fireDBController.updateMoney(
                                            questionResponceModel.money == 5000
                                                ? 0
                                                : questionResponceModel.money ~/
                                                    2);
                                        Get.offAllNamed(Routes.homeView);
                                      },
                                      child: Text(
                                        "quit".tr,
                                        style: CustomTextStyle.text4,
                                      )),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      "cancel".tr,
                                      style: CustomTextStyle.text4,
                                    ),
                                  )
                                ],
                              ));
                    },
                  ),
          ),
          body: Obx(
            () => isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              strokeWidth: 12,
                              backgroundColor: AppColors.yellowAccentColor,
                              value: 0,
                            ),
                            Center(
                                child: Text(
                              "${questionController.iSecond.value}\n seconds",
                              textAlign: TextAlign.center,
                              style: CustomTextStyle.text3,
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: const EdgeInsets.all(14),
                          margin: const EdgeInsets.all(17),
                          decoration: BoxDecoration(
                              color: Get.theme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            questionResponceModel.question,
                            style: Get.textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      answerWidget(
                          selctopt: optLockA.value,
                          onDoublePress: () {
                            questionController.timer?.cancel();
                            optLockA.value = true;
                            if (questionResponceModel.correctAnswer ==
                                questionResponceModel.option1) {
                              questionController.quiestionQuizID.value =
                                  fireDBController.listQuizzes[fireDBController
                                      .selectedCat.value]['Quizid'];
                              questionController.winerMoney.value =
                                  questionResponceModel.money;
                              Get.toNamed(Routes.winView);
                            } else {
                              questionController.looserMoney.value =
                                  questionResponceModel.money ~/ 2;
                              questionController.correctAns.value =
                                  questionResponceModel.correctAnswer;
                              Get.toNamed(Routes.looserView);
                            }
                          },
                          option: "A. ${questionResponceModel.option1}"),
                      answerWidget(
                          selctopt: optLockB.value,
                          onDoublePress: () {
                            questionController.timer?.cancel();

                            optLockB.value = true;
                            if (questionResponceModel.correctAnswer ==
                                questionResponceModel.option2) {
                              questionController.quiestionQuizID.value =
                                  fireDBController.listQuizzes[fireDBController
                                      .selectedCat.value]['Quizid'];
                              questionController.winerMoney.value =
                                  questionResponceModel.money;
                              Get.toNamed(Routes.winView);
                            } else {
                              questionController.looserMoney.value =
                                  questionResponceModel.money ~/ 2;
                              questionController.correctAns.value =
                                  questionResponceModel.correctAnswer;

                              Get.toNamed(Routes.looserView);
                            }
                          },
                          option: "B. ${questionResponceModel.option2}"),
                      answerWidget(
                          selctopt: optLockC.value,
                          onDoublePress: () {
                            questionController.timer?.cancel();

                            optLockC.value = true;
                            if (questionResponceModel.correctAnswer ==
                                questionResponceModel.option3) {
                              questionController.quiestionQuizID.value =
                                  fireDBController.listQuizzes[fireDBController
                                      .selectedCat.value]['Quizid'];
                              questionController.winerMoney.value =
                                  questionResponceModel.money;
                              Get.toNamed(Routes.winView);
                            } else {
                              questionController.looserMoney.value =
                                  questionResponceModel.money ~/ 2;
                              questionController.correctAns.value =
                                  questionResponceModel.correctAnswer;
                              Get.toNamed(Routes.looserView);
                            }
                          },
                          option: "C. ${questionResponceModel.option3}"),
                      answerWidget(
                          selctopt: optLockD.value,
                          onDoublePress: () {
                            questionController.timer?.cancel();

                            optLockD.value = true;
                            if (questionResponceModel.correctAnswer ==
                                questionResponceModel.option4) {
                              questionController.quiestionQuizID.value =
                                  fireDBController.listQuizzes[fireDBController
                                      .selectedCat.value]['Quizid'];
                              questionController.winerMoney.value =
                                  questionResponceModel.money;
                              Get.toNamed(Routes.winView);
                            } else {
                              questionController.looserMoney.value =
                                  questionResponceModel.money ~/ 2;
                              questionController.correctAns.value =
                                  questionResponceModel.correctAnswer;
                              Get.toNamed(Routes.looserView);
                            }
                          },
                          option: "D. ${questionResponceModel.option4}"),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  answerWidget(
      {void Function()? onDoublePress, String? option, bool selctopt = false}) {
    return InkWell(
      onTap: () {
        logger.i("Double Tap to lock answer");
      },
      onDoubleTap: onDoublePress,
      child: Container(
          width: Get.width,
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
          decoration: BoxDecoration(
              color: selctopt
                  ? AppColors.yellowAccentColor
                  : Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(34)),
          child: Text(
            option!,
            style: CustomTextStyle.text5,
            textAlign: TextAlign.center,
          )),
    );
  }
}
