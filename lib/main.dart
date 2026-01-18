import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/app/routes/route_generator.dart';
import 'package:restaurantapp/app/theme/light_theme.dart';
import 'package:restaurantapp/core/constants/app_constants.dart';
import 'package:restaurantapp/core/constants/restaurant_constants.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/about/cubit/about_cubit.dart';
import 'package:restaurantapp/features/app_status/cubit/app_status_cubit.dart';
import 'package:restaurantapp/features/authentication/bloc/auth_bloc.dart';
import 'package:restaurantapp/features/cart/bloc/cart_bloc.dart';
import 'package:restaurantapp/features/cart/cubit/item_state_cubit.dart';
import 'package:restaurantapp/features/cart/cubit/subtotal_cubit.dart';
import 'package:restaurantapp/features/checkout/cubit/postal_code_handler_cubit.dart';
import 'package:restaurantapp/features/checkout/discount_cubit/discount_cubit.dart';
import 'package:restaurantapp/features/indian_nepalese_food/bloc/indian_nepalese_food_bloc.dart';
import 'package:restaurantapp/features/meal_deals/bloc/meal_deal_bloc.dart';
import 'package:restaurantapp/features/order_day/cubit/order_day_cubit.dart';
import 'package:restaurantapp/features/postal_code/bloc/search_postal_code_bloc.dart';
import 'package:restaurantapp/features/settings/cubit/settings_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await dotenv.load(fileName: ".env");
  String stripePublishableKey = dotenv.get("PUBLISHABLE_KEY");

  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
  final appLinks = AppLinks();
  appLinks.uriLinkStream.listen((uri) {
    log(uri.toString());
  });
  String token =
      locator<SharedPreferences>().getString(AppConstants.bearerToken) ?? "";
  runApp(
    MyApp(
      token: token,
    ),
  );
}

bool isLoggedIn() {
  return locator<SharedPreferences>().getString(AppConstants.bearerToken) !=
      null;
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final String token;
  const MyApp({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: locator<AuthBloc>()..add(AuthenticationCheckEvent()),
        ),
        BlocProvider.value(
          value: locator<IndianNepaleseFoodBloc>(),
        ),
        BlocProvider.value(
          value: locator<DiscountCubit>(),
        ),
        BlocProvider.value(
          value: locator<MealDealBloc>(),
        ),
        BlocProvider.value(
          value: locator<AppStatusCubit>(),
        ),
        BlocProvider.value(
          value: locator<SettingsCubit>(),
        ),
        BlocProvider.value(
          value: locator<SubtotalCubit>(),
        ),
        BlocProvider.value(
          value: locator<OrderDayCubit>(),
        ),
        BlocProvider.value(
          value: locator<SearchPostalCodeBloc>(),
        ),
        BlocProvider.value(
          value: locator<CartBloc>(),
        ),
        BlocProvider.value(
          value: locator<AboutCubit>(),
        ),
        BlocProvider.value(
          value: locator<CurrentServiceTypeCubit>(),
        ),
        BlocProvider.value(
          value: locator<PostalCodeHandlerCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: RestaurantConstants.name,
            debugShowCheckedModeBanner: false,
            initialRoute:
                // token.isNotEmpty
                // ?
                // AppRoutes.dashboardScreen,
                // : AppRoutes.loginScreen,
                AppRoutes.newDashboardScreen,
            onGenerateRoute: RouteGenerator.onGenerateRoute,
            navigatorKey: navigatorKey,
            theme: lightTheme,
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            navigatorObservers: [ChuckerFlutter.navigatorObserver],
          );
        },
      ),
    );
  }
}
