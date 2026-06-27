import 'package:sofra/core/network/api_constants.dart';
import 'package:sofra/core/network/api_service.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> signup({
    required String fullName,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<UserModel> login({required String email, required String password}) async {
    final response = await apiService.post(
      endpoint: ApiConstants.login,
      data: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data['data'];
      return UserModel.fromJson(data['user'], token: data['token']);
    } else {
      String errorMessage = 'Login failed. Please try again.';
      if (response.data is Map) {
        errorMessage = response.data['message'] ?? response.data['error']?['message'] ?? errorMessage;
      }
      throw Exception(errorMessage);
    }
  }

  @override
  Future<UserModel> signup({required String fullName, required String email, required String password}) async {
    final response = await apiService.post(
      endpoint: ApiConstants.signup,
      data: {
        "fullName": fullName,
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data['data'];
      return UserModel.fromJson(data['user'], token: data['token']);
    } else {
      String errorMessage = 'Signup failed. Please try again.';
      if (response.data is Map) {
        errorMessage = response.data['message'] ?? response.data['error']?['message'] ?? errorMessage;
      }
      throw Exception(errorMessage);
    }
  }
}
