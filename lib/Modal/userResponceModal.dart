import 'package:cloud_firestore/cloud_firestore.dart';

class UserResponceModal {
  String userName;
  String userEmail;
  String userPhotoUrl;
  int userMoney;
  String userRank;
  int userLevel;

  UserResponceModal(
      {this.userName = "",
      this.userEmail = "",
      this.userPhotoUrl = "",
      this.userMoney = 0,
      this.userRank = "",
      this.userLevel = 0});

  factory UserResponceModal.fromJson(DocumentSnapshot toJson) {
    final data = toJson.data() as Map<String, dynamic>;
    return UserResponceModal(
        userEmail: data['email'],
        userLevel: data['level'],
        userMoney: data['money'],
        userName: data['name'],
        userPhotoUrl: data['photoUrl'],
        userRank: data['rank']);
  }

  Map<String, dynamic> tomap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = userEmail;
    data['name'] = userName;
    data['photoUrl'] = userPhotoUrl;
    data['money'] = userMoney;
    data['rank'] = userRank;
    data['level'] = userLevel;
    return data;
  }
}
