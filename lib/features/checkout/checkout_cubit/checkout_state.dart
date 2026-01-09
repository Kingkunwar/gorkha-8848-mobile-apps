part of 'checkout_cubit.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

class CheckingOutState extends CheckoutState {}

class CheckedOutState extends CheckoutState {
  final String message;
  CheckedOutState({
    required this.message,
  });
}

class CheckOutFailureState extends CheckoutState {
  final Failure failure;
  CheckOutFailureState({
    required this.failure,
  });
}
