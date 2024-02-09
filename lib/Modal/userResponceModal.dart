class UserResponceModal {
  String userName;
  String userEmail;
  String userPhotoUrl;
  int userMoney;
  String userRank;
  int userLevel;

  UserResponceModal(this.userName, this.userEmail, this.userPhotoUrl,
      this.userMoney, this.userRank, this.userLevel);

  factory UserResponceModal.fromJson(Map<String, dynamic> json) =>
      UserResponceModal(json['name'], json['email'], json['photoUrl'],
          json['money'], json['rank'], json['level']);

  Map<String, dynamic> toJson() => {
        "name": userName,
        "email": userEmail,
        "photoUrl": userPhotoUrl,
        'money': userMoney,
        'rank': userRank,
        'level': userLevel
      };
}
