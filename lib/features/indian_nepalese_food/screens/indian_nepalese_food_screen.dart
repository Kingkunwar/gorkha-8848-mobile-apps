import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/custom_widgets/custom_circular_progress_indicator.dart';
import 'package:restaurantapp/app/custom_widgets/custom_pull_to_refresh_widget.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/indian_nepalese_food/bloc/indian_nepalese_food_bloc.dart';
import 'package:restaurantapp/features/indian_nepalese_food/repo/indian_nepalese_food_repo.dart';
import 'package:restaurantapp/features/pizza_and_sides/widgets/pizza_and_sides_tabbar_widget.dart';

class IndianNepaleseFoodScreen extends StatefulWidget {
  const IndianNepaleseFoodScreen({super.key});

  @override
  State<IndianNepaleseFoodScreen> createState() =>
      _IndianNepaleseFoodScreenState();
}

class _IndianNepaleseFoodScreenState extends State<IndianNepaleseFoodScreen> {
  _fetchFoods() {
    locator<IndianNepaleseFoodBloc>().add(
      FetchIndianNepaleseFoodEvent(
        foodType: FoodType.indianAndNepalese,
      ),
    );
  }

  @override
  void initState() {
    _fetchFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppBar(
      //   title: "Select Items",
      //   actions: [
      //     CustomCartWidget(),
      //   ],
      // ),
      body: BlocBuilder<IndianNepaleseFoodBloc, IndianNepaleseFoodState>(
        builder: (context, state) {
          if (state is IndianNepaleseFoodFetchingState) {
            return const Center(
              child: CustomCircularProgressIndicator(),
            );
          } else if (state is IndianNepaleseFoodFetchErrorState) {
            return CustomPullToRefresh(
              onRefresh: () {
                _fetchFoods();
              },
              child: Center(
                child: Text(
                  state.failure.message!,
                ),
              ),
            );
          } else if (state is IndianNepaleseFoodFetchedState) {
            // return IndianNepaleseFoodWidget(
            //   onRefresh: _fetchFoods,
            //   state: state,
            // );
            return PizzaAndSidesTabbarScreen(
              onRefresh: _fetchFoods,
              state: state,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
