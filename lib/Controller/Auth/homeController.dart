import 'package:get/get.dart';
import 'package:kbcquiz/LocalDB/localDB.dart';

class HomeController extends GetxController {
  RxString userRank = "".obs;
  RxInt userLevel = 0.obs;
  RxInt userMoney = 0.obs;
  RxString userID = "".obs;
  RxString userName = "".obs;
  RxString userPhotoUrl = "".obs;
  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  getUserData() async {
    await LocalDB.getRank().then((value) {
      userRank.value = value.toString();
    });
    await LocalDB.getLevel().then((value) {
      userLevel.value = value ?? 0;
    });
    await LocalDB.getMoney().then((value) {
      userMoney.value = value ?? 0;
    });
    await LocalDB.getUserID().then((value) {
      userID.value = value.toString();
    });
    await LocalDB.getName().then((value) {
      userName.value = value.toString();
    });
    await LocalDB.getUrl().then((value) {
      userPhotoUrl.value = value.toString();
    });
  }
}
