import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kbcquiz/Controller/Auth/authController.dart';
import 'package:kbcquiz/Controller/Auth/homeController.dart';
import 'package:kbcquiz/Localizations/iconConstant.dart';
import 'package:kbcquiz/Routes/pages.dart';
import 'package:kbcquiz/Themes/appColors.dart';
import 'package:kbcquiz/Themes/customTextStyle.dart';

// ignore: must_be_immutable
class SideDrawer extends StatelessWidget {
  SideDrawer({super.key});
  AuthController authController = Get.put(AuthController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: AppColors.purpleColor,
        child: ListView(
          children: [
            InkWell(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(homeController.userPhotoUrl.value),
                        ),
                        title: Text(
                          homeController.userName.value,
                          style: CustomTextStyle.text4,
                        ),
                        subtitle: Text(
                          "Rs. ${homeController.userMoney.value}",
                          style: CustomTextStyle.text3,
                        )),
                  ),
                  Center(
                    child: Text(
                        "Leaderboard -  ${homeController.userRank.value}th Rank",
                        style: CustomTextStyle.text4),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            listItem(
              label: "dailyquiz".tr,
              icon: IconCons.quizIcon,
              onTap: () => Get.offAllNamed(Routes.homeView),
            ),
            listItem(
                label: "leaderboard".tr,
                icon: IconCons.leaderIcon,
                onTap: () => Get.offAllNamed(Routes.homeView)),
            listItem(
                label: "howtouse".tr,
                icon: IconCons.qaIcon,
                onTap: () => Get.offAllNamed(Routes.homeView)),
            listItem(
                label: "aboutus".tr,
                icon: IconCons.faceIcon,
                onTap: () => Get.offAllNamed(Routes.homeView)),
            listItem(
                label: "logout".tr,
                icon: Icons.logout,
                onTap: () async {
                  await authController.googleSignOut();
                })
          ],
        ),
      ),
    );
  }

  Widget listItem(
      {required String label, required IconData icon, void Function()? onTap}) {
    return ListTile(
        leading: Icon(
          icon,
          color: AppColors.whiteColor,
        ),
        hoverColor: AppColors.white60Color,
        title: Text(label, style: CustomTextStyle.text3),
        onTap: onTap);
  }
}
