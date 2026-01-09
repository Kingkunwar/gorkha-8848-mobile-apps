part of 'indian_nepalese_food_bloc.dart';

sealed class IndianNepaleseFoodState {}

final class IndianNepaleseFoodInitial extends IndianNepaleseFoodState {}

class IndianNepaleseFoodFetchingState extends IndianNepaleseFoodState {}

class IndianNepaleseFoodFetchedState extends IndianNepaleseFoodState {
  final IndianNepaleseFoodModel foodModel;
  IndianNepaleseFoodFetchedState({
    required this.foodModel,
  });
}

class IndianNepaleseFoodFetchErrorState extends IndianNepaleseFoodState {
  final Failure failure;
  IndianNepaleseFoodFetchErrorState({
    required this.failure,
  });
}
