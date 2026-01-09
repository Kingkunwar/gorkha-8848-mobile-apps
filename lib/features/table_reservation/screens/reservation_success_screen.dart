import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';

class ReservationSuccessScreen extends StatefulWidget {
  const ReservationSuccessScreen({
    super.key,
  });

  @override
  State<ReservationSuccessScreen> createState() =>
      _ReservationSuccessScreenState();
}

class _ReservationSuccessScreenState extends State<ReservationSuccessScreen> {
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
          showBackArrow: false,
          title: "Reservation Success",
        ),
        body: ScreenPadding(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Lottie.asset(
                    'assets/check.json',
                  ),
                ),
                10.verticalSpace,
                Text(
                  "Check your order confirmation in both email inbox and junk box, if there is no confirmation email then please contact the restaurant.",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                20.verticalSpace,
                PrimaryButton(
                  buttonTitle: "Back to Home",
                  onTap: () {
                    pushAndRemoveUntil(
                      routeName: AppRoutes.newDashboardScreen,
                    );
                  },
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
