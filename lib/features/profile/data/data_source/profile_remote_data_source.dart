import 'package:dio/dio.dart';
import 'package:sofra/core/network/api_constants.dart';
import 'package:sofra/core/network/api_service.dart';
import '../models/profile_user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileUserModel> getProfile();

  Future<ProfileUserModel> updateProfile({String? displayName, String? bio});

  Future<ProfileUserModel> updateAvatar(String filePath);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiService apiService;

  ProfileRemoteDataSourceImpl(this.apiService);

  @override
  Future<ProfileUserModel> getProfile() async {
    final response = await apiService.get(endpoint: ApiConstants.getMe);

    if (response.statusCode == 200) {
      final data = response.data['data'] as Map<String, dynamic>;
      return ProfileUserModel.fromJson(data);
    } else {
      final message = _extractMessage(
        response.data,
        'Failed to fetch profile.',
      );
      throw Exception(message);
    }
  }

  @override
  Future<ProfileUserModel> updateProfile({
    String? displayName,
    String? bio,
  }) async {
    final body = <String, dynamic>{};
    if (displayName != null) body['displayName'] = displayName;
    if (bio != null) body['bio'] = bio;

    final response = await apiService.patch(
      endpoint: ApiConstants.updateMe,
      data: body,
    );

    if (response.statusCode == 200) {
      final data = response.data['data'] as Map<String, dynamic>;
      return ProfileUserModel.fromJson(data);
    } else {
      final message = _extractMessage(
        response.data,
        'Failed to update profile.',
      );
      throw Exception(message);
    }
  }

  @override
  Future<ProfileUserModel> updateAvatar(String filePath) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(filePath, filename: 'avatar.jpg'),
    });

    final response = await apiService.patchMultipart(
      endpoint: ApiConstants.updateAvatar,
      formData: formData,
    );

    if (response.statusCode == 200) {
      final data = response.data['data'] as Map<String, dynamic>;
      return ProfileUserModel.fromJson(data);
    } else {
      final message = _extractMessage(
        response.data,
        'Failed to update avatar.',
      );
      throw Exception(message);
    }
  }

  String _extractMessage(dynamic responseData, String fallback) {
    if (responseData is Map) {
      return responseData['message'] ??
          responseData['error']?['message'] ??
          fallback;
    }
    return fallback;
  }
}
