part of 'search_postal_code_bloc.dart';

sealed class SearchPostalCodeEvent {}

class SearchForPostalCodeEvent extends SearchPostalCodeEvent {
  final String query;
  SearchForPostalCodeEvent({
    required this.query,
  });
}

class ClearPostalCodeEvent extends SearchPostalCodeEvent {}

class PostalCodeInitialEvent extends SearchPostalCodeEvent {}
