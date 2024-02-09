import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static const moneyKey = "fgjfbgfngmfbn";
  static const ranKey = "roeigke";
  static const levelKey = "weiohjsdf";
  static const uidKey = "dfdbfbdsjfd";
  static const nkey = "dfdsfdsfgfsdf";
  static const pkey = "dsfdsfdfsda";
  static Future<bool> saveUserID(String uid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(uidKey, uid);
  }

  static Future<String?> getUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(uidKey);
  }

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

  static Future<int?> getLevel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getInt(levelKey);
  }

  static Future<bool> saveMoney(int money) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(moneyKey, money);
  }

  static Future<int?> getMoney() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getInt(moneyKey);
  }

  static Future<bool> saveName(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(nkey, name);
  }

  static Future<String?> getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(nkey);
  }

  static Future<bool> saveUrl(String prourl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(pkey, prourl);
  }

  static Future<String?> getUrl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(pkey);
  }
}
