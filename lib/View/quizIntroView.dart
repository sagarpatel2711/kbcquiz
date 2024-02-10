// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kbcquiz/Controller/Auth/homeController.dart';
import 'package:kbcquiz/Controller/fireDBController.dart';
import 'package:kbcquiz/Themes/customTextStyle.dart';

class QuizIntroView extends StatelessWidget {
  QuizIntroView({super.key});
  FireDBController fireDBController = Get.put(FireDBController());
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> quizIntro = fireDBController.listQuizzes;
    int quizIndex = fireDBController.selectedCat.value;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          child: Text(
            "startquiz".tr,
            style: CustomTextStyle.text1,
          ),
          onPressed: () async {
            await fireDBController.buyQuiz(
                quizID: "${quizIntro[quizIndex]['Quizid']}",
                quizPrice: quizIntro[quizIndex]['unlock_money'],
                userID: homeController.userID.value);
          }),
      appBar: AppBar(
        title: Text(
          "quizapp".tr,
        ),
      ),
      body: Column(
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
