part of 'home_navigation_cubit.dart';

@immutable
sealed class HomeNavigationState {
  final int currentIndex;

  const HomeNavigationState(this.currentIndex);
}

final class HomeNavigationInitial extends HomeNavigationState {
  const HomeNavigationInitial() : super(0);
}

final class HomeNavigationChanged extends HomeNavigationState {
  const HomeNavigationChanged(super.currentIndex);
}
