part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileUserModel user;
  ProfileLoaded(this.user);
}

class ProfileUpdateSuccess extends ProfileState {
  final ProfileUserModel user;
  ProfileUpdateSuccess(this.user);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
