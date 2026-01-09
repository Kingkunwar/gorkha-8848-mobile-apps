import 'package:get_it/get_it.dart';
import 'package:restaurantapp/core/network/client/base_client.dart';
import 'package:restaurantapp/features/about/cubit/about_cubit.dart';
import 'package:restaurantapp/features/about/repo/about_repo.dart';
import 'package:restaurantapp/features/app_status/cubit/app_status_cubit.dart';
import 'package:restaurantapp/features/app_status/repo/app_status_repo.dart';
import 'package:restaurantapp/features/authentication/bloc/auth_bloc.dart';
import 'package:restaurantapp/features/authentication/repo/auth_repo.dart';
import 'package:restaurantapp/features/cart/bloc/cart_bloc.dart';
import 'package:restaurantapp/features/cart/cubit/item_state_cubit.dart';
import 'package:restaurantapp/features/cart/cubit/subtotal_cubit.dart';
import 'package:restaurantapp/features/checkout/checkout_cubit/checkout_cubit.dart';
import 'package:restaurantapp/features/checkout/cubit/postal_code_handler_cubit.dart';
import 'package:restaurantapp/features/checkout/discount_cubit/discount_cubit.dart';
import 'package:restaurantapp/features/checkout/repo/checkout_repo.dart';
import 'package:restaurantapp/features/history/cubit/user_history_cubit.dart';
import 'package:restaurantapp/features/history/repo/user_history_repo.dart';
import 'package:restaurantapp/features/indian_nepalese_food/bloc/indian_nepalese_food_bloc.dart';
import 'package:restaurantapp/features/indian_nepalese_food/repo/indian_nepalese_food_repo.dart';
import 'package:restaurantapp/features/meal_deals/bloc/meal_deal_bloc.dart';
import 'package:restaurantapp/features/meal_deals/repo/meal_deal_repo.dart';
import 'package:restaurantapp/features/order_day/cubit/order_day_cubit.dart';
import 'package:restaurantapp/features/postal_code/bloc/search_postal_code_bloc.dart';
import 'package:restaurantapp/features/settings/cubit/settings_cubit.dart';
import 'package:restaurantapp/features/settings/repo/settings_repo.dart';
import 'package:restaurantapp/features/table_reservation/repo/table_reservation_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(prefs);

  locator.registerFactory<BaseClient>(
    () => BaseClientImpl(),
  );
  locator.registerFactory<AboutRepo>(
    () => AboutImpl(
      locator(),
    ),
  );
  locator.registerFactory<CheckoutRepo>(
    () => CheckoutImpl(
      locator(),
    ),
  );
  locator.registerSingleton<AuthRepo>(
    AuthImpl(
      locator(),
    ),
  );
  locator.registerFactory<SettingsRepo>(
    () => SettingsImpl(
      locator(),
    ),
  );

  locator.registerFactory<UserHistoryRepo>(
    () => UserHistoryImpl(
      locator(),
    ),
  );
  locator.registerFactory<TableReservationRepo>(
    () => TableReservationImpl(
      locator(),
    ),
  );
  locator.registerSingleton<IndianNepaleseFoodRepo>(
    IndianNepaleseFoodImpl(
      locator(),
    ),
  );
  locator.registerSingleton<MealDealRepo>(
    MealDealImpl(
      locator(),
    ),
  );

  //bloc

  locator.registerLazySingleton(
    () => AuthBloc(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => OrderDayCubit(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SubtotalCubit(),
  );
  locator.registerLazySingleton(
    () => SearchPostalCodeBloc(),
  );
  locator.registerLazySingleton(
    () => DiscountCubit(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => MealDealBloc(
      locator(),
    ),
  );
  locator.registerFactory<AppStatusRepo>(
    () => AppStatusRepoImpl(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => AppStatusCubit(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => IndianNepaleseFoodBloc(
      locator(),
    ),
  );
  locator.registerSingleton<CartBloc>(
    CartBloc(),
  );
  locator.registerSingleton<AboutCubit>(
    AboutCubit(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SettingsCubit(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => PostalCodeHandlerCubit(),
  );
  locator.registerLazySingleton(
    () => CurrentServiceTypeCubit(),
  );
  locator.registerLazySingleton(
    () => CheckoutCubit(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => UserHistoryCubit(
      locator(),
    ),
  );
}
