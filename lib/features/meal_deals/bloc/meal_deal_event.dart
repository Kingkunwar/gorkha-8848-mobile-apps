part of 'meal_deal_bloc.dart';

sealed class MealDealEvent {}

class FetchMealDealEvent extends MealDealEvent {}

class ResetMealDealEvent extends MealDealEvent {}
