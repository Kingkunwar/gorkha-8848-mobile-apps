import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/functions/show_toast.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/constants/restaurant_constants.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/cart/cubit/item_state_cubit.dart';
import 'package:restaurantapp/features/cart/screens/cart_screen.dart';
import 'package:restaurantapp/features/dashboard/widgets/select_service_type_popup.dart';
import 'package:restaurantapp/main.dart';

class IntroWidget extends StatelessWidget {
  final bool isCollectionEnabled;
  final bool isDeliveryEnabled;
  final bool isTableReservationEnabled;
  const IntroWidget({
    super.key,
    required this.isCollectionEnabled,
    required this.isDeliveryEnabled,
    required this.isTableReservationEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenPadding(
      child: Column(
        children: [
          Text(
            "Welcome to",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            RestaurantConstants.name,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 39.h,
          ),
          SizedBox(
            height: 30.h,
          ),
          PrimaryButton(
            onTap: () async {
              if (isDeliveryEnabled || isCollectionEnabled) {
                final ServiceType? serviceType = await showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        insetPadding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        child: ScreenPadding(
                          padding: 20.w,
                          child: SelectServiceTypePopup(
                            isCollectionEnabled: isCollectionEnabled,
                            isDeliveryEnabled: isDeliveryEnabled,
                          ),
                        ),
                      );
                    });
                if (serviceType != null) {
                  locator<CurrentServiceTypeCubit>().setSeriveItem(serviceType);
                  pushNamed(
                    context: navigatorKey.currentContext!,
                    routeName: serviceType == ServiceType.delivery
                        ? AppRoutes.enterPostalCodeScreen
                        : AppRoutes.selectItemScreen,
                    arguments: 0,
                  );
                }
              } else {
                showErrorToast(
                  "Online order is currently under maintenance. Please try again later.",
                );
              }
            },
            buttonTitle: "Order now",
            isWidthLimited: true,
          ),
          if (isTableReservationEnabled) ...{
            SizedBox(
              height: 10.h,
            ),
            PrimaryButton(
              buttonTitle: "Table Reservation",
              isWidthLimited: true,
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.reservationScreen,
                );
              },
            ),
          },
          SizedBox(
            height: 35.h,
          ),
        ],
      ),
    );
  }
}
