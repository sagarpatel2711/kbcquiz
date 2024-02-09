import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static final moneyKey = "fgjfbgfngmfbn";
  static final ranKey = "roeigke";
  static final levelKey = "weiohjsdf";

  static Future<bool> saveRank(String rank) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(ranKey, rank);
  }

  static Future<String?> getRank() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(ranKey);
  }

  static Future<bool> saveLevel(int level) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(levelKey, level);
  }

  static Future<String?> getLevel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(levelKey);
  }

  static Future<bool> saveMoney(int money) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(moneyKey, money);
  }

  static Future<String?> getMoney() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(moneyKey);
  }
}
