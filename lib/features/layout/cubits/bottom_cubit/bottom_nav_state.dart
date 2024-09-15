part of 'bottom_nav_cubit.dart';

sealed class BottomNavState {
  const BottomNavState();
}

final class BottomNavInitial extends BottomNavState {}

class ChangeBottomNavState extends BottomNavState {
  const ChangeBottomNavState();
}
