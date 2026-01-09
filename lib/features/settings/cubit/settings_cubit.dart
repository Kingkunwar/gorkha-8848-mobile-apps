import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/core/network/error/network_utils_models.dart';
import 'package:restaurantapp/features/settings/models/settings_model.dart';
import 'package:restaurantapp/features/settings/repo/settings_repo.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepo _repo;
  SettingsCubit(this._repo) : super(SettingsInitial());
  resetSettings() {
    emit(SettingsInitial());
  }

  fetchSettings() async {
    if (state is! SettingsFetchedState) {
      emit(SettingsFetchingState());
    }
    final response = await _repo.fetchSettings();
    emit(
      response.fold(
        (l) => SettingsFetchedState(
          settings: l,
        ),
        (r) => SettingsFetchErrorState(
          failure: r,
        ),
      ),
    );
  }
}
