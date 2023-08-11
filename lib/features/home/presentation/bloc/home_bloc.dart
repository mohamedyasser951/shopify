import 'package:bloc/bloc.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:equatable/equatable.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepo homeRepo;
  CategoryModel? categoryModel;

  HomeBloc({
    required this.homeRepo,
  }) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is GetHomeDataEvent) {
        emit(GetHomeDataLoadingState());
        var failureOrData = await homeRepo.getHomeData();
        failureOrData.fold(
            (error) => emit(GetHomeDataErrorState(error: error.toString())),
            (model) => emit(GetHomeDataSuccessState(homeModel: model)));
      }
      if (event is GetCategoriesEvent) {
        emit(GetCategoriesLoadingState());
        var failureOrData = await homeRepo.getCategories();
        failureOrData.fold(
            (error) => emit(GetCategoriesErrorState(error: error.toString())),
            (model) {
          categoryModel = model;
          emit(GetCategoriesSuccessState(categoryModel: model));
        });
      }
    });
  }
}
