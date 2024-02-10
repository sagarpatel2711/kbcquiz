import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kbcquiz/Controller/Auth/homeController.dart';
import 'package:kbcquiz/Controller/fireDBController.dart';
import 'package:kbcquiz/Themes/customTextStyle.dart';

// ignore: must_be_immutable
class QuizIntroView extends StatelessWidget {
  QuizIntroView({super.key});
  FireDBController fireDBController = Get.put(FireDBController());
  HomeController homeController = Get.put(HomeController());
  RxBool quizIsUnlock = false.obs;
  RxBool isLoading = false.obs;

  getQuizUnlockStatus() async {
    isLoading.value = true;

    await fireDBController
        .checkQuizUnlock(
            userID: homeController.userID.value,
            quizDocID: fireDBController
                .listQuizzes[fireDBController.selectedCat.value]['Quizid'])
        .then((quizStatus) {
      quizIsUnlock.value = quizStatus;
    });
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    getQuizUnlockStatus();
    List<Map<String, dynamic>> quizIntro = fireDBController.listQuizzes;
    int quizIndex = fireDBController.selectedCat.value;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () => isLoading.value
            ? const SizedBox()
            : ElevatedButton(
                child: Text(
                  quizIsUnlock.value ? "startquiz".tr : "Unlock Quiz",
                  style: CustomTextStyle.text1,
                ),
                onPressed: () async {
                  await fireDBController
                      .buyQuiz(
                          quizID: "${quizIntro[quizIndex]['Quizid']}",
                          quizPrice: quizIntro[quizIndex]['unlock_money'],
                          userID: homeController.userID.value)
                      .then((buyQuiz) {
                    if (buyQuiz) {
                      quizIsUnlock.value = true;
                    } else {
                      return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  "donothaveenoughmoney".tr,
                                  style: Get.textTheme.displayLarge,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "ok",
                                        style: Get.textTheme.displayLarge,
                                      ))
                                ],
                              ));
                    }
                  });
                }),
      ),
      appBar: AppBar(
        title: Text(
          "quizapp".tr,
        ),
      ),
      body: Obx(
        () => isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${quizIntro[quizIndex]["quiz_name"]}",
                    textAlign: TextAlign.center,
                    style: Get.textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Image.network(
                    "${quizIntro[quizIndex]["quiz_thumbnail"]}".tr,
                    fit: BoxFit.cover,
                    height: 230,
                    width: Get.width,
                  ),
                  _listTile(Icons.topic_outlined, "Related To -",
                      "${quizIntro[quizIndex]["topics"]}"),
                  _listTile(Icons.topic_outlined, "Duration -",
                      "${quizIntro[quizIndex]['duration']} Minutes"),
                  _listTile(Icons.money, "Money -",
                      "Rs. ${quizIntro[quizIndex]['unlock_money']}"),
                  _listTile(Icons.topic_outlined, "About Quiz -",
                      "${quizIntro[quizIndex]['about_quiz']} "),
                ],
              ),
      ),
    );
  }

  _listTile(IconData icon, String title, String subTitle) {
    return ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: Get.textTheme.displayLarge,
        ),
        subtitle: Text(
          subTitle,
          style: Get.textTheme.labelMedium,
        ));
  }
}
