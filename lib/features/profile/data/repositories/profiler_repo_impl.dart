import 'package:dio/dio.dart';
import 'package:sofra/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:sofra/features/profile/data/models/profile_user_model.dart';
import 'package:sofra/features/profile/domain/repositories/profiler_repo.dart';

class ProfilerRepoImpl implements ProfilerRepo {
  final ProfileRemoteDataSource remoteDataSource;

  ProfilerRepoImpl(this.remoteDataSource);

  @override
  Future<ProfileUserModel> getProfile() async {
    try {
      return await remoteDataSource.getProfile();
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? e.message ?? 'Unknown error occurred';
      throw Exception(message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ProfileUserModel> updateProfile({
    String? displayName,
    String? bio,
  }) async {
    try {
      return await remoteDataSource.updateProfile(
        displayName: displayName,
        bio: bio,
      );
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? e.message ?? 'Unknown error occurred';
      throw Exception(message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ProfileUserModel> updateAvatar(String filePath) async {
    try {
      return await remoteDataSource.updateAvatar(filePath);
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? e.message ?? 'Unknown error occurred';
      throw Exception(message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
