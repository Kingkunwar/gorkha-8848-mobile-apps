import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/get_background_decoration.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/cart/cubit/item_state_cubit.dart';
import 'package:restaurantapp/features/cart/screens/cart_screen.dart';

class OrderCompletedScreen extends StatefulWidget {
  const OrderCompletedScreen({super.key});

  @override
  State<OrderCompletedScreen> createState() => _OrderCompletedScreenState();
}

class _OrderCompletedScreenState extends State<OrderCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pushAndRemoveUntil(
          routeName: AppRoutes.newDashboardScreen,
        );
        return true;
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Order Placed Successfully",
          showBackArrow: false,
        ),
        body: Container(
          decoration: getBackgroundDecoration(),
          child: ScreenPadding(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/check.json',
                ),
                20.verticalSpace,
                Text(
                  "We thank you for choosing us.",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                30.verticalSpace,
                Text(
                  locator<CurrentServiceTypeCubit>().state ==
                          ServiceType.collection
                      ? "Please check your email for order details. Usually collection will be ready within 20 minutes. Please be advised that during busy times collection orders can take up to 30 minutes to be ready."
                      : "Please check your email for order details. Usually delivery will be ready within 45 minutes. Please advised that during busy times, delivery orders can take up to 1 hours to be ready.",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                30.verticalSpace,
                PrimaryButton(
                  buttonTitle: "Back to home",
                  onTap: () {
                    pushAndRemoveUntil(
                      routeName: AppRoutes.newDashboardScreen,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
