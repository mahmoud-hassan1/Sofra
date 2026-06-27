class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String? token;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, {String? token}) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      token: token,
    );
  }
}
