import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/meal_deals/model/meal_deal_model.dart';
import 'package:restaurantapp/features/meal_deals/repo/meal_deal_repo.dart';

part 'meal_deal_event.dart';
part 'meal_deal_state.dart';

class MealDealBloc extends Bloc<MealDealEvent, MealDealState> {
  final MealDealRepo _repo;
  MealDealBloc(this._repo) : super(MealDealInitial()) {
    on<FetchMealDealEvent>((event, emit) async {
      emit(MealDealFetchingState());
      final response = await _repo.fetchMealDeals();
      emit(
        response.fold(
          (l) => MealDealFetchedState(
            mealDeal: l,
          ),
          (r) => MealDealFetchErrorState(
            failure: r,
          ),
        ),
      );
    });

    on<ResetMealDealEvent>((event, emit) {
      emit(MealDealInitial());
    });
  }
}
