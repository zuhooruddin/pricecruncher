class UserModel {
  String? userName;
  String? userId;
  String? profilePic;
  String? phoneNumber;
  List? favorites;
  List? invites;

  UserModel({
    this.userName,
    this.userId,
    this.profilePic,
    this.phoneNumber,
    this.favorites,
    this.invites,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'userId': userId,
      'profilePic': profilePic,
      'phoneNumber': phoneNumber,
      'favorites': favorites,
      'invites': invites,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] as String,
      userId: map['userId'] as String,
      profilePic: map['profilePic'] as String,
      phoneNumber: map['phoneNumber'] as String,
      favorites: map['favorites'] as List,
      invites: map['invites'] as List,
    );
  }
}
