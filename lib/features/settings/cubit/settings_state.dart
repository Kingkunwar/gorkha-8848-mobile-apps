part of 'settings_cubit.dart';

sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

class SettingsFetchingState extends SettingsState {}

class SettingsFetchedState extends SettingsState {
  final SettingsModel settings;
  SettingsFetchedState({
    required this.settings,
  });
}

class SettingsFetchErrorState extends SettingsState {
  final Failure failure;
  SettingsFetchErrorState({
    required this.failure,
  });
}
