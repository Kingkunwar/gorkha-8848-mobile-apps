part of 'meal_deal_bloc.dart';

sealed class MealDealState {}

final class MealDealInitial extends MealDealState {}

class MealDealFetchingState extends MealDealState {}

class MealDealFetchedState extends MealDealState {
  final MealDealModel mealDeal;
  MealDealFetchedState({
    required this.mealDeal,
  });
}

class MealDealFetchErrorState extends MealDealState {
  final Failure failure;
  MealDealFetchErrorState({
    required this.failure,
  });
}
