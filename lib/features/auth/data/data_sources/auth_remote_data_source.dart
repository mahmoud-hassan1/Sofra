import 'package:dio/dio.dart';
import 'package:sofra/core/network/api_constants.dart';
import 'package:sofra/core/network/api_service.dart';
import 'package:sofra/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String Password});
  Future<UserModel> signup({
    required String fullName,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImp({required this.apiService});
  @override
  Future<UserModel> login({
    required String email,
    required String Password,
  }) async {
    final response = await apiService.post(
      endpoint: ApiConstants.login,
      data: {'email': email, 'password': Password},
    );
    final data = response.data['data'];
    final token = data['token'];
    final userJson = data['user'];
    return UserModel.fromJson(userJson, token: token);
  }

  @override
  Future<UserModel> signup({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      endpoint: ApiConstants.signup,
      data: {
        'fullName': fullName,
        'email': email,
        'password': password,
        'passwordConfirm': password,
      },
    );
    final data = response.data['data'];
    final token = data['token'];
    final userJson = data['user'];
    return UserModel.fromJson(userJson, token: token);
  }
}
