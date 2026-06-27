import 'package:sofra/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login({required String email,required String password});
  Future<UserModel> signup({required String fullName,required String email,required String password});
}