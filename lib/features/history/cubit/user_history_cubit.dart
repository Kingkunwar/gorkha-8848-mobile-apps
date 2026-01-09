import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/history/models/user_history_model.dart';
import 'package:restaurantapp/features/history/repo/user_history_repo.dart';

part 'user_history_state.dart';

class UserHistoryCubit extends Cubit<UserHistoryState> {
  final UserHistoryRepo _repo;
  UserHistoryCubit(this._repo) : super(UserHistoryInitial());

  fetchUserHistory() async {
    emit(UserHistoryFetchingState());
    final response = await _repo.fetchUserHistory();
    response.fold(
      (l) => emit(
        UserHistoryFetchedState(
          userHistory: l,
        ),
      ),
      (r) => emit(
        UserHistoryFetchErrorState(
          failure: r,
        ),
      ),
    );
  }

  clearUserHistory() {
    emit(UserHistoryInitial());
  }
}
