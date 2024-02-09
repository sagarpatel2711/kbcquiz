import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kbcquiz/Controller/Auth/homeController.dart';
import 'package:kbcquiz/Themes/appColors.dart';

import '../Widgets/drawer.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});
  HomeController homeController = Get.put(HomeController());
  RxBool isLoad = false.obs;
  loadData() async {
    isLoad.value = true;
    await homeController.getUserData();
    isLoad.value = false;
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return RefreshIndicator(
      onRefresh: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeView()));
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('kbcquizgame'.tr),
          ),
          drawer: SideDrawer(),
          body: Obx(
            () => isLoad.value
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        carouselSlider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              circularAvatar(AppColors.purpleColor),
                              circularAvatar(AppColors.redColor),
                              circularAvatar(AppColors.greenColor),
                              circularAvatar(AppColors.yellowAccentColor),
                            ],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              elevation: 5,
                              child: Image.network(
                                "urlcaraslider".tr,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "richestintheworld".tr,
                            style: Get.textTheme.displayLarge,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  homeController.userPhotoUrl.value),
                              radius: 40,
                            ),
                            title: Text(
                              homeController.userName.value,
                              style: Get.textTheme.displayLarge,
                            ),
                            subtitle: Text(
                                "Rs. ${homeController.userMoney.value}",
                                style: Get.textTheme.labelLarge)),
                        carouselSlider(),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              circularAvatar(AppColors.purpleColor),
                              circularAvatar(AppColors.redColor),
                              circularAvatar(AppColors.greenColor),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              circularAvatar(AppColors.purpleColor),
                              circularAvatar(AppColors.redColor),
                              circularAvatar(AppColors.greenColor),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              circularAvatar(AppColors.purpleColor),
                              circularAvatar(AppColors.redColor),
                              circularAvatar(AppColors.greenColor),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          )),
    );
  }

  Widget circularAvatar(Color? backgroundColor) {
    return CircleAvatar(backgroundColor: backgroundColor, radius: 35);
  }

  Widget carouselSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CarouselSlider(
          items: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                        "urlcaraslider".tr,
                      ),
                      fit: BoxFit.cover)),
            ),
          ],
          options: CarouselOptions(
              height: 180,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8)),
    );
  }
}
