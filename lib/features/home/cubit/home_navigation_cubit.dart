import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_navigation_state.dart';

class HomeNavigationCubit extends Cubit<HomeNavigationState> {
  HomeNavigationCubit() : super(HomeNavigationInitial());
  void changeIndex(int index) {
    emit(HomeNavigationChanged(index));
  }
}
