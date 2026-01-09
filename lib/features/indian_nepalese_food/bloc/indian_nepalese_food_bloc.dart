import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/indian_nepalese_food/model/indian_nepalese_food_model.dart';
import 'package:restaurantapp/features/indian_nepalese_food/repo/indian_nepalese_food_repo.dart';
part 'indian_nepalese_food_event.dart';

part 'indian_nepalese_food_state.dart';

class IndianNepaleseFoodBloc
    extends Bloc<IndianNepaleseFoodEvent, IndianNepaleseFoodState> {
  final IndianNepaleseFoodRepo _repo;
  IndianNepaleseFoodBloc(this._repo) : super(IndianNepaleseFoodInitial()) {
    on<IndianNepaleseResetEvent>((event, emit) {
      emit(IndianNepaleseFoodInitial());
    });

    on<FetchIndianNepaleseFoodEvent>((event, emit) async {
      emit(IndianNepaleseFoodFetchingState());
      Either<IndianNepaleseFoodModel, Failure>? response;
      if (event.foodType == FoodType.indianAndNepalese) {
        response = await _repo.fetchFoodItems();
      } else {
        response = await _repo.fetchPizzaAndSides();
      }
      emit(
        response.fold(
          (l) => IndianNepaleseFoodFetchedState(
            foodModel: l,
          ),
          (r) => IndianNepaleseFoodFetchErrorState(
            failure: r,
          ),
        ),
      );
    });
  }
}
