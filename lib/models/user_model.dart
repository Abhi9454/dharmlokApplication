class UserModel {
  final String userFullName;
  final String userEmail;
  final String userType;
  final String phoneNumber;
  final String token;

  UserModel(
      {required this.userFullName,
        required this.userEmail,
        required this.userType,
        required this.phoneNumber,
        required this.token,
      });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userFullName: json['name'],
      userEmail: json['email'],
      userType: json['userType'],
      phoneNumber: json['phoneNumber'],
      token: json['token'],
    );
  }
}