import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kbcquiz/Controller/fireDBController.dart';
import 'package:kbcquiz/Controller/questionController.dart';
import 'package:kbcquiz/Localizations/iconConstant.dart';
import 'package:kbcquiz/Localizations/imageAssets.dart';
import 'package:kbcquiz/Routes/pages.dart';
import 'package:kbcquiz/Themes/appColors.dart';
import 'package:kbcquiz/Themes/customTextStyle.dart';

class LooserView extends StatelessWidget {
  LooserView();
  QuestionController questionController = Get.put(QuestionController());
  FireDBController fireDBController = Get.put(FireDBController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageAssets.looserImg), fit: BoxFit.cover)),
      child: Scaffold(
          floatingActionButton: ElevatedButton(
            child: Text(
              "retry".tr,
              style: CustomTextStyle.text4,
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ohsorry".tr, style: CustomTextStyle.text6),
                  Text("ansincorrect".tr, style: CustomTextStyle.text4),
                  Text("CORRECT ANSWER IS ${questionController.correctAns} ",
                      style: CustomTextStyle.text4),
                  const SizedBox(
                    height: 15,
                  ),
                  Text("youwon".tr, style: CustomTextStyle.text3),
                  Text(
                      "Rs.${questionController.looserMoney.value == 2500 ? 0 : questionController.looserMoney}",
                      style: CustomTextStyle.text3),
                  const SizedBox(
                    height: 15,
                  ),
                  const Icon(IconCons.errorIcon,
                      size: 100, color: AppColors.whiteColor),
                  ElevatedButton(
                    child: Text("gotorewards".tr),
                    onPressed: () async {
                      await fireDBController
                          .updateMoney(questionController.looserMoney.value);
                      Get.offAllNamed(Routes.homeView);
                    },
                  )
                ]),
          )),
    );
  }
}
