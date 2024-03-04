import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kbcquiz/Controller/Auth/homeController.dart';
import 'package:kbcquiz/Localizations/iconConstant.dart';
import 'package:kbcquiz/Themes/appColors.dart';
import 'package:kbcquiz/Themes/customTextStyle.dart';

// ignore: must_be_immutable
class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(IconCons.shareIcon)),
          IconButton(
              onPressed: () {}, icon: const Icon(IconCons.personAddIcon)),
        ],
        title: Text(
          "profile".tr,
          style: CustomTextStyle.text1,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40),
            decoration: const BoxDecoration(
                color: AppColors.purpleColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(homeController.userPhotoUrl.value),
                      radius: 50,
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor),
                        child: const Icon(
                          IconCons.editIcon,
                          color: AppColors.purpleAccentColor,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${homeController.userName.value}\nRs.${homeController.userMoney.value}",
                  style: CustomTextStyle.text4,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text("#${homeController.userRank.value}",
                    style: CustomTextStyle.text1),
                Text("rank".tr, style: CustomTextStyle.text4),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Text(
            "leaderboard".tr,
            style: Get.textTheme.labelLarge,
          ),
          /** 
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: SizedBox(
                  height: 300,
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    LeadersList[index].data()["photoUrl"]),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(LeadersList[index]
                                          .data()["name"]
                                          .toString()
                                          .length >=
                                      12
                                  ? "${(LeadersList[index].data()["name"]).toString().substring(0, 12)}..."
                                  : (LeadersList[index].data()["name"])
                                      .toString())
                            ],
                          ),
                          leading: Text(
                            "#${index + 1}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                              "Rs.${k_m_b_generator(int.parse(LeadersList[index].data()["money"].toString()))}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                            thickness: 1,
                            color: Colors.purple,
                            indent: 10,
                            endIndent: 10,
                          ),
                      itemCount: LeadersList.length),
                ),
              ),
            ],
          )
      */
        ],
      ),
    );
  }
}
