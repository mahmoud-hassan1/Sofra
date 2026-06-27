import 'package:dio/dio.dart';
import 'package:sofra/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:sofra/features/auth/data/models/user_model.dart';

import 'auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserModel> login({required String email, required String password}) async {
    try {
      return await remoteDataSource.login(email: email,Password: password);
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message ?? ' Unknown error occurred';
      throw Exception(message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel> signup({required String fullName, required String email, required String password}) async {
    try {
      return await remoteDataSource.signup(fullName: fullName, email: email, password: password);
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message ?? 'Unknown error occurred';
      throw Exception(message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}