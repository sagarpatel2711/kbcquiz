import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kbcquiz/Controller/Auth/authController.dart';
import 'package:kbcquiz/Localizations/imageAssets.dart';
import 'package:kbcquiz/Themes/appColors.dart';
import 'package:kbcquiz/Themes/customTextStyle.dart';
import 'package:sign_in_button/sign_in_button.dart';

// ignore: must_be_immutable
class SignInView extends StatelessWidget {
  SignInView({super.key});
  RxBool isLoading = false.obs;

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purpleColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageAssets.kbcImg),
            const SizedBox(
              height: 35,
            ),
            Text(
              "welcomekbcquizapp".tr,
              style: CustomTextStyle.text1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(
              () => isLoading.value
                  ? const CircularProgressIndicator()
                  : SignInButton(Buttons.google, onPressed: () async {
                      isLoading.value = true;
                      await authController.signInWithGoogleMethod();

                      isLoading.value = false;
                    }),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "continuingtnc".tr,
              style: CustomTextStyle.text2,
            )
          ],
        ),
      ),
    );
  }
}
