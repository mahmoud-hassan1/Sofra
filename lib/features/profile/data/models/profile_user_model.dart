class ProfileUserModel {
  final String id;
  final String fullName;
  final String? displayName;
  final String email;
  final String? bio;
  final String? avatarUrl;

  ProfileUserModel({
    required this.id,
    required this.fullName,
    this.displayName,
    required this.email,
    this.bio,
    this.avatarUrl,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      displayName: json['displayName'] as String?,
      email: json['email'] ?? '',
      bio: json['bio'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  ProfileUserModel copyWith({
    String? id,
    String? fullName,
    String? displayName,
    String? email,
    String? bio,
    String? avatarUrl,
  }) {
    return ProfileUserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
