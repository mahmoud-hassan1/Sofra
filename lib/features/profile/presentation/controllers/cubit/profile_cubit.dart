import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofra/features/profile/data/models/profile_user_model.dart';
import 'package:sofra/features/profile/domain/repositories/profiler_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfilerRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final user = await profileRepo.getProfile();
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(_clean(e)));
    }
  }

  Future<void> updateProfile({String? displayName, String? bio}) async {
    emit(ProfileLoading());
    try {
      final user = await profileRepo.updateProfile(
        displayName: displayName,
        bio: bio,
      );
      emit(ProfileUpdateSuccess(user));
    } catch (e) {
      emit(ProfileError(_clean(e)));
    }
  }

  Future<void> updateAvatar(String filePath) async {
    emit(ProfileLoading());
    try {
      final user = await profileRepo.updateAvatar(filePath);
      emit(ProfileUpdateSuccess(user));
    } catch (e) {
      emit(ProfileError(_clean(e)));
    }
  }

  String _clean(Object e) => e.toString().replaceAll('Exception: ', '');
}
