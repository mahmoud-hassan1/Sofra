import 'package:sofra/features/profile/data/models/profile_user_model.dart';

abstract class ProfilerRepo {
  Future<ProfileUserModel> getProfile();
  Future<ProfileUserModel> updateProfile({String? displayName, String? bio});
  Future<ProfileUserModel> updateAvatar(String filePath);
}
