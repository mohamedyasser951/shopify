
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepoImplem homeRepoImplem;

  HomeBloc(
    this.homeRepoImplem,
  ) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is GetHomeDataEvent) {
        emit(GetHomeDataLoadingState());
        var failureOrData = await homeRepoImplem.getHomeData();

        failureOrData.fold(
            (error) => emit(GetHomeDataErrorState(error: error.toString())),
            (model) => emit(GetHomeDataSuccessState(homeModel: model)));
      }
    });
  }
}
