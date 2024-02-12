import 'dart:async';

import 'package:get/get.dart';
import 'package:kbcquiz/Modal/questionResponceModal.dart';
import 'package:kbcquiz/Routes/pages.dart';

import '../Utilitys/logger.dart';

class QuestionController extends GetxController {
  RxInt iSecond = 30.obs;
  RxInt looserMoney = 0.obs;
  RxInt winerMoney = 0.obs;
  RxString correctAns = "".obs;
  RxString quiestionQuizID = "".obs;
  RxInt questionMoney = 5000.obs;
  QuestionResponceModel questionResponceModel = QuestionResponceModel();

  Timer? timer;

  queTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (iSecond.value != 0) {
        iSecond.value--;
        if (iSecond.value == 0) {
          questionMoney.value == 5000 ? 0 : questionMoney.value ~/ 2;

          Get.toNamed(Routes.looserView);
          logger.i("time out");
        }
      }
    });
  }

  @override
  void onInit() {
    queTimer();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    timer!.cancel();
    // TODO: implement onClose
    super.onClose();
  }
}
