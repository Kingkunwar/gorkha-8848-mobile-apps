part of 'indian_nepalese_food_bloc.dart';

sealed class IndianNepaleseFoodEvent {}

class FetchIndianNepaleseFoodEvent extends IndianNepaleseFoodEvent {
  final FoodType foodType;
  FetchIndianNepaleseFoodEvent({
    required this.foodType,
  });
}

class IndianNepaleseResetEvent extends IndianNepaleseFoodEvent {}
