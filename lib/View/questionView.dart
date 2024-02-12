import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kbcquiz/Localizations/imageAssets.dart';
import 'package:kbcquiz/Themes/appColors.dart';
import 'package:kbcquiz/Themes/customTextStyle.dart';
import 'package:kbcquiz/Widgets/lifeLineDrawer.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(ImageAssets.bgImg))),
      child: Scaffold(
        onDrawerChanged: (isOpened) {},
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            "Rs.",
            style: CustomTextStyle.text1,
          ),
          centerTitle: true,
        ),
        drawer: const LifeLineDrawer(),
        floatingActionButton: ElevatedButton(
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
                            onPressed: () async {},
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
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
                    "seconds",
                    style: CustomTextStyle.text1,
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
                  "questionModel.question",
                  style: Get.textTheme.labelMedium,
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
              height: 10,
            ),
            answerWidget(option: "A. "),
            answerWidget(option: "B. "),
            answerWidget(option: "C. "),
            answerWidget(option: "D. "),
          ],
        ),
      ),
    );
  }

  answerWidget(
      {void Function()? onTap, void Function()? onLongPress, String? option}) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
          width: Get.width,
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(34)),
          child: Text(
            option!,
            style: CustomTextStyle.text5,
            textAlign: TextAlign.center,
          )),
    );
  }
}
