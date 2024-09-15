import 'package:bloc/bloc.dart';
part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());
  int bottomNavIndex = 0;

  void changeBottomNave(int currentIndex) {
    bottomNavIndex = currentIndex;
    emit(ChangeBottomNavState());
  }
}
