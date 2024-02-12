import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kbcquiz/Controller/questionController.dart';
import 'package:kbcquiz/Localizations/iconConstant.dart';
import 'package:kbcquiz/Themes/appColors.dart';
import 'package:kbcquiz/Themes/customTextStyle.dart';

class LifeLineDrawer extends StatelessWidget {
  LifeLineDrawer({super.key});
  QuestionController questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Text("lifeline".tr, style: Get.textTheme.labelMedium)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _lifelineWidget(
                    icon: IconCons.peopleIcon,
                    onTap: () {},
                    title: "audiencepoll".tr),
                _lifelineWidget(
                    icon: IconCons.changeCircleIcon,
                    onTap: () {},
                    title: "jokerquestion".tr),
                _lifelineWidget(
                    icon: IconCons.starHalfIcon,
                    onTap: () {},
                    title: "fifty50".tr),
                _lifelineWidget(
                    icon: IconCons.desktopMacIcon,
                    onTap: () {},
                    title: "asktheexpert".tr),
              ],
            ),
            const SizedBox(height: 5),
            Divider(
              color: Get.theme.dividerColor,
              thickness: 1,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text("prizes".tr, style: Get.textTheme.displayLarge)),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 13,
                  itemBuilder: (context, index) {
                    if (2500 * (pow(2, index + 1)) ==
                        questionController.questionMoney.value) {
                      return ListTile(
                        tileColor: Colors.deepPurpleAccent,
                        leading: Text(
                          "${index + 1}.",
                          style: CustomTextStyle.text4,
                        ),
                        title: Text(
                          "Rs.${2500 * (pow(2, index + 1))}",
                          style: CustomTextStyle.text4,
                        ),
                        trailing: const Icon(
                          IconCons.circleIcon,
                          color: AppColors.purpleAccentColor,
                        ),
                      );
                    }
                    return ListTile(
                      leading: Text(
                        "${index + 1}.",
                        style: Get.textTheme.displayLarge,
                      ),
                      title: Text(
                        "Rs.${2500 * (pow(2, index + 1))}",
                        style: Get.textTheme.displayLarge,
                      ),
                      trailing: const Icon(IconCons.circleIcon),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  _lifelineWidget({void Function()? onTap, IconData? icon, String? title}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            elevation: 12,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.purpleAccentColor),
                child: Icon(icon, size: 32, color: AppColors.whiteColor)),
          ),
          const SizedBox(height: 5),
          Text(
            title!,
            textAlign: TextAlign.center,
            style: Get.textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
