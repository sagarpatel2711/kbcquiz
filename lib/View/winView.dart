import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kbcquiz/Controller/fireDBController.dart';
import 'package:kbcquiz/Controller/questionController.dart';
import 'package:kbcquiz/Localizations/imageAssets.dart';
import 'package:kbcquiz/Routes/pages.dart';
import 'package:kbcquiz/Themes/customTextStyle.dart';

class WinView extends StatelessWidget {
  WinView({super.key});
  late ConfettiController confettiController;
  QuestionController questionController = Get.put(QuestionController());
  FireDBController fireDBController = Get.put(FireDBController());
  void initController() {
    confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    initController();
    confettiController.play();

    return WillPopScope(
      onWillPop: () async {
        final exitQuiz = await showWarning(
            context: context,
            title: "quitquiz".tr,
            content:
                "You will get Rs.${questionController.winerMoney} In Your Account.");
        return exitQuiz ?? false;
      },
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAssets.winImg), fit: BoxFit.cover)),
        child: Scaffold(
            floatingActionButton: ElevatedButton(
              child: Text("sharewithfriends".tr),
              onPressed: () {},
            ),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("cong".tr, style: CustomTextStyle.text6),
                  Text("correctans".tr,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text("youwon".tr, style: CustomTextStyle.text3),
                  Text("Rs.${questionController.winerMoney}",
                      style: CustomTextStyle.text3),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(ImageAssets.chequeImg)),
                  ElevatedButton(
                    child: Text("nextquestion".tr),
                    onPressed: () {
                      questionController.questionMoney.value =
                          questionController.winerMoney.value * 2;
                      questionController.iSecond.value = 30;
                      questionController.queTimer();
                      Get.offNamed(Routes.questionView);
                    },
                  )
                ]),
                buildConfettiWidget(confettiController, pi / 2),
              ],
            )),
      ),
    );
  }

  Align buildConfettiWidget(controller, double blastDirection) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        maximumSize: const Size(40, 30),
        shouldLoop: false,
        confettiController: controller,
        blastDirection: blastDirection,
        blastDirectionality: BlastDirectionality.explosive,
        maxBlastForce: 20,
        minBlastForce: 8,
        emissionFrequency: 0.2,
        numberOfParticles: 8,
        gravity: 0.01,
      ),
    );
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
}
