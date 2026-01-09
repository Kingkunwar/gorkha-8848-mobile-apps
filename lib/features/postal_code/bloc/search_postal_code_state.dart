part of 'search_postal_code_bloc.dart';

sealed class SearchPostalCodeState {}

final class SearchPostalCodeInitial extends SearchPostalCodeState {}

class SearchingPostalCodeState extends SearchPostalCodeState {}

class SearchSuccessState extends SearchPostalCodeState {
  final List<String> fetchedAddresses;
  final String deliveryCharge;
  SearchSuccessState({
    required this.fetchedAddresses,
    required this.deliveryCharge,
  });
}

class SearchFailureState extends SearchPostalCodeState {
  final Failure failure;
  SearchFailureState({
    required this.failure,
  });
}
