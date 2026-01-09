import 'package:flutter/material.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/app_status/cubit/app_status_cubit.dart';
import 'package:restaurantapp/features/authentication/bloc/auth_bloc.dart';
import 'package:restaurantapp/features/cart/bloc/cart_bloc.dart';
import 'package:restaurantapp/features/cart/cubit/item_state_cubit.dart';
import 'package:restaurantapp/features/cart/cubit/subtotal_cubit.dart';
import 'package:restaurantapp/features/checkout/checkout_cubit/checkout_cubit.dart';
import 'package:restaurantapp/features/checkout/cubit/postal_code_handler_cubit.dart';
import 'package:restaurantapp/features/checkout/discount_cubit/discount_cubit.dart';
import 'package:restaurantapp/features/history/cubit/user_history_cubit.dart';
import 'package:restaurantapp/features/indian_nepalese_food/bloc/indian_nepalese_food_bloc.dart';
import 'package:restaurantapp/features/meal_deals/bloc/meal_deal_bloc.dart';
import 'package:restaurantapp/features/order_day/cubit/order_day_cubit.dart';
import 'package:restaurantapp/features/postal_code/bloc/search_postal_code_bloc.dart';
import 'package:restaurantapp/features/settings/cubit/settings_cubit.dart';
import 'package:restaurantapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logout() async {
  locator<SharedPreferences>().clear();
  locator<AuthBloc>().add(LogoutEvent());
  locator<OrderDayCubit>().resetOrderDay();
  locator<SubtotalCubit>().resetSubTotal();
  locator<SearchPostalCodeBloc>().add(PostalCodeInitialEvent());
  locator<DiscountCubit>().resetDiscount();
  locator<MealDealBloc>().add(ResetMealDealEvent());
  locator<IndianNepaleseFoodBloc>().add(IndianNepaleseResetEvent());
  locator<CartBloc>().add(ResetCartEvent());
  locator<SettingsCubit>().resetSettings();
  locator<PostalCodeHandlerCubit>().resetPostalCode();
  locator<CurrentServiceTypeCubit>().resetCurrentServiceType();
  locator<CheckoutCubit>().resetCheckoutDetails();
  locator<UserHistoryCubit>().clearUserHistory();
  locator<AppStatusCubit>().resetAppStatus();

  // await locator.reset();
  // await setupLocator();
  Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
    AppRoutes.newDashboardScreen,
    (route) => false,
  );
}
