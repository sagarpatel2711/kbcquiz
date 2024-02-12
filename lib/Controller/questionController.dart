import 'dart:async';

import 'package:get/get.dart';

import '../Utilitys/logger.dart';

class QuestionController extends GetxController {
  RxInt iSecond = 30.obs;

  Timer? timer;

  queTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (iSecond.value != 0) {
        iSecond.value--;
        if (iSecond.value == 0) {
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
