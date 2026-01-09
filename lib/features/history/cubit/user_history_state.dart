part of 'user_history_cubit.dart';

sealed class UserHistoryState {}

final class UserHistoryInitial extends UserHistoryState {}

class UserHistoryFetchingState extends UserHistoryState {}

class UserHistoryFetchedState extends UserHistoryState {
  final UserHistoryModel userHistory;

  UserHistoryFetchedState({
    required this.userHistory,
  });
}

class UserHistoryFetchErrorState extends UserHistoryState {
  final Failure failure;
  UserHistoryFetchErrorState({
    required this.failure,
  });
}
