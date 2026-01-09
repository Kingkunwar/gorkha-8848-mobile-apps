import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/custom_widgets/web_view_screen.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/authentication/screens/change_password_screen.dart';
import 'package:restaurantapp/features/authentication/screens/login_screen.dart';
import 'package:restaurantapp/features/authentication/screens/signup_screen.dart';
import 'package:restaurantapp/features/cart/screens/cart_screen.dart';
import 'package:restaurantapp/features/checkout/screens/checkout_screen.dart';
import 'package:restaurantapp/features/checkout/screens/complete_order_screen.dart';
import 'package:restaurantapp/features/checkout/screens/order_completed_screen.dart';
import 'package:restaurantapp/features/contact_us/contact_us_screen.dart';
import 'package:restaurantapp/features/dashboard/screens/new_dashboard_screen.dart';
import 'package:restaurantapp/features/history/cubit/user_history_cubit.dart';
import 'package:restaurantapp/features/history/screens/user_history_screen.dart';
import 'package:restaurantapp/features/indian_nepalese_food/screens/indian_nepalese_food_screen.dart';
import 'package:restaurantapp/features/meal_deals/screens/meal_deal_screen.dart';
import 'package:restaurantapp/features/pizza_and_sides/screens/pizza_and_sides_screen.dart';
import 'package:restaurantapp/features/postal_code/enter_postal_code_screen.dart';
import 'package:restaurantapp/features/profile/screens/profile_screen.dart';
import 'package:restaurantapp/features/select_items/screen/select_items_screen.dart';
import 'package:restaurantapp/features/settings/screen/settings_screen.dart';
import 'package:restaurantapp/features/table_reservation/models/reservation_model.dart';
import 'package:restaurantapp/features/table_reservation/models/reservation_success_model.dart';
import 'package:restaurantapp/features/table_reservation/screens/confirm_reservation_screen.dart';
import 'package:restaurantapp/features/table_reservation/screens/reservation_success_screen.dart';
import 'package:restaurantapp/features/table_reservation/screens/table_reservation_screen.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Object? arguments = settings.arguments;
    switch (settings.name) {
      // case AppRoutes.dashboardScreen:
      //   return CupertinoPageRoute(
      //     builder: (context) => const DashboardScreen(),
      // );
      case AppRoutes.pizzaAndSidesScreen:
        return CupertinoPageRoute(
          builder: (context) => const PizzaAndSidesScreen(),
        );
      case AppRoutes.enterPostalCodeScreen:
        return CupertinoPageRoute(
          builder: (context) => const EnterPostalCodeScreen(),
        );
      case AppRoutes.mealDealScreen:
        return CupertinoPageRoute(
          builder: (context) => const MealDealScreen(),
        );
      case AppRoutes.changePasswordScreen:
        return CupertinoPageRoute(
          builder: (context) => const ChangePasswordScreen(),
        );
      case AppRoutes.newDashboardScreen:
        return CupertinoPageRoute(
          builder: (context) => const NewDashboardScreen(),
        );
      case AppRoutes.selectItemScreen:
        return CupertinoPageRoute(
          builder: (context) => SelectItemsScreen(
            index: arguments as int,
          ),
        );
      case AppRoutes.completeOrderScreen:
        return CupertinoPageRoute(
          builder: (context) => CompleteOrderScreen(
            vm: arguments as CompleteOrderScreenViewModel,
          ),
        );
      case AppRoutes.orderCompletedScreen:
        return CupertinoPageRoute(
          builder: (context) => const OrderCompletedScreen(),
        );

      case AppRoutes.contactUsScreen:
        return CupertinoPageRoute(
          builder: (context) => const ContactUsScreen(),
        );
      case AppRoutes.userHistoryScreen:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider.value(
            value: locator<UserHistoryCubit>(),
            child: const UserHistoryScreen(),
          ),
        );
      case AppRoutes.reservationScreen:
        return CupertinoPageRoute(
          builder: (context) => const TableReservationScreen(),
        );
      case AppRoutes.signupScreen:
        return CupertinoPageRoute(
          builder: (context) => SignupScreen(
            vm: arguments as CompleteOrderScreenViewModel?,
          ),
        );
      case AppRoutes.loginScreen:
        return CupertinoPageRoute(
          builder: (context) => LoginScreen(
            vm: arguments as CompleteOrderScreenViewModel?,
          ),
        );
      // case AppRoutes.forgotPasswordScreen:
      //   return CupertinoPageRoute(
      //     builder: (context) => const ResetPasswordScreen(),
      //   );
      case AppRoutes.indianAndNepaleseScreen:
        return CupertinoPageRoute(
          builder: (context) => const IndianNepaleseFoodScreen(),
        );
      case AppRoutes.checkoutScreen:
        return CupertinoPageRoute(
          builder: (context) => CheckoutScreen(
            checkoutItems: arguments as CheckoutViewModel?,
          ),
        );
      case AppRoutes.cartScreen:
        return CupertinoPageRoute(
          builder: (context) => const CartScreen(),
        );
      case AppRoutes.restaurantInfoScreen:
        return CupertinoPageRoute(
          builder: (context) => const SettingsScreen(),
        );
      case AppRoutes.webViewScreen:
        return CupertinoPageRoute(
          builder: (context) => WebViewScreen(
            pageUrl: arguments as String,
          ),
        );
      case AppRoutes.profileScreen:
        return CupertinoPageRoute(
          builder: (context) => const ProfileScreen(),
        );
      // case AppRoutes.reservationContactDetailsScreen:
      //   return CupertinoPageRoute(
      //     builder: (context) => ReservationContactDetailScreen(
      //       reservationModel: arguments as ReservationModel,
      //     ),
      //   );
      case AppRoutes.confirmReservationScreen:
        return CupertinoPageRoute(
          builder: (context) => ConfirmReservationScreen(
            reservation: arguments as ReservationModel,
          ),
        );
      case AppRoutes.reservationSuccessScreen:
        return CupertinoPageRoute(
          builder: (context) => ReservationSuccessScreen(
            reservation: arguments as ReservationSuccessModel,
          ),
        );
      default:
        return CupertinoPageRoute(
          builder: (context) => const NewDashboardScreen(),
        );
    }
  }
}
