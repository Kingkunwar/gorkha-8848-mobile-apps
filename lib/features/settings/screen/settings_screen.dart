import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/app/custom_widgets/custom_circular_progress_indicator.dart';
import 'package:restaurantapp/app/custom_widgets/custom_pull_to_refresh_widget.dart';
import 'package:restaurantapp/app/functions/get_background_decoration.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/settings/cubit/settings_cubit.dart';
import 'package:restaurantapp/features/settings/widgets/restaurant_time_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  _fetchSettings() {
    locator<SettingsCubit>().fetchSettings();
  }

  @override
  void initState() {
    _fetchSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Restaurant info",
      ),
      body: Container(
        decoration: getBackgroundDecoration(),
        child: CustomPullToRefresh(
          onRefresh: _fetchSettings,
          child: BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
            if (state is SettingsFetchingState) {
              return const Center(
                child: CustomCircularProgressIndicator(),
              );
            } else if (state is SettingsFetchedState) {
              return SingleChildScrollView(
                  child: Column(
                children: [
                  RestaurantTimeWidget(
                    state: state,
                  ),
                ],
              ));
            } else if (state is SettingsFetchErrorState) {
              return Center(
                child: Text(
                  state.failure.message ?? '',
                ),
              );
            }
            return const SizedBox();
          }),
        ),
      ),
    );
  }
}
