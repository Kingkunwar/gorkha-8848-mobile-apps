part of 'order_day_cubit.dart';

sealed class OrderDayState {}

final class OrderDayInitial extends OrderDayState {}

class OrderDayFetchedState extends OrderDayState {
  final Map<String, dynamic> orderDays;

  OrderDayFetchedState({
    required this.orderDays,
  });
}

class OrderDayFetchErrorState extends OrderDayState {
  final Failure failure;
  OrderDayFetchErrorState({
    required this.failure,
  });
}
