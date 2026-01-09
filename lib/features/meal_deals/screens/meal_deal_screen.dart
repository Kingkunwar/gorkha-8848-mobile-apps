import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/custom_widgets/custom_circular_progress_indicator.dart';
import 'package:restaurantapp/app/custom_widgets/custom_pull_to_refresh_widget.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/meal_deals/bloc/meal_deal_bloc.dart';
import 'package:restaurantapp/features/meal_deals/widgets/meal_deal_widget.dart';

class MealDealScreen extends StatefulWidget {
  const MealDealScreen({super.key});

  @override
  State<MealDealScreen> createState() => _MealDealScreenState();
}

class _MealDealScreenState extends State<MealDealScreen> {
  _fetchMealDeals() {
    locator<MealDealBloc>().add(FetchMealDealEvent());
  }

  @override
  void initState() {
    _fetchMealDeals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // appBar: const CustomAppBar(),
      // floatingActionButton: const FloatingCartWidget(),
      body: ScreenPadding(
        child: BlocBuilder<MealDealBloc, MealDealState>(
          builder: (context, state) {
            if (state is MealDealFetchingState) {
              return const Center(
                child: CustomCircularProgressIndicator(),
              );
            } else if (state is MealDealFetchedState) {
              return MealDealWidget(
                state: state,
              );
            } else if (state is MealDealFetchErrorState) {
              return CustomPullToRefresh(
                onRefresh: () {
                  _fetchMealDeals();
                },
                child: Center(
                  child: Text(
                    state.failure.message!,
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
