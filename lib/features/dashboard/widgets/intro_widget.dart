import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/functions/show_toast.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/extensions/cached_network_extension.dart';
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
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: "https://gorkha8848.co.uk/images/logo.png",
              height: 190.h,
              width: 190.w,
            ).withPlaceHolder(),
          ),

          // Decorative top element
          // Container(
          //   width: 60.w,
          //   height: 4.h,
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).primaryColor,
          //     borderRadius: BorderRadius.circular(2.r),
          //   ),
          // ),
          // SizedBox(height: 30.h),

          // // Welcome text with elegant styling
          // Text(
          //   "Welcome to",
          //   style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          //         color: Colors.white.withOpacity(0.9),
          //         fontWeight: FontWeight.w300,
          //         letterSpacing: 2.0,
          //       ),
          // ),
          // SizedBox(height: 15.h),

          // // Restaurant name with prominent styling
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          //   decoration: BoxDecoration(
          //     color: Colors.white.withOpacity(0.1),
          //     borderRadius: BorderRadius.circular(12.r),
          //     border: Border.all(
          //       color: Theme.of(context).primaryColor.withOpacity(0.5),
          //       width: 2,
          //     ),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Theme.of(context).primaryColor.withOpacity(0.3),
          //         blurRadius: 20,
          //         spreadRadius: 2,
          //       ),
          //     ],
          //   ),
          //   child: Text(
          //     RestaurantConstants.name,
          //     style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold,
          //       letterSpacing: 1.5,
          //       shadows: [
          //         Shadow(
          //           color: Colors.black.withOpacity(0.5),
          //           blurRadius: 10,
          //         ),
          //       ],
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          // SizedBox(height: 40.h),

          // // Tagline or subtitle
          // Text(
          //   "Authentic Nepalese & Indian Cuisine",
          //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          //         color: Colors.white.withOpacity(0.85),
          //         fontStyle: FontStyle.italic,
          //         letterSpacing: 1.0,
          //       ),
          //   textAlign: TextAlign.center,
          // ),
          SizedBox(height: 50.h),

          // Order Now button with enhanced styling
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: PrimaryButton(
              onTap: () async {
                if (isDeliveryEnabled || isCollectionEnabled) {
                  final ServiceType? serviceType = await showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          insetPadding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                          ),
                          backgroundColor: Colors.white,
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
                    locator<CurrentServiceTypeCubit>()
                        .setSeriveItem(serviceType);
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
              buttonTitle: "Order Now",
              isWidthLimited: false,
              padding: EdgeInsets.symmetric(
                vertical: 14.h,
                horizontal: 30.w,
              ),
            ),
          ),

          if (isTableReservationEnabled) ...{
            SizedBox(height: 20.h),
            // Table Reservation button with elegant styling
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: PrimaryButton(
                buttonTitle: "Table Reservation",
                isWidthLimited: false,
                padding: EdgeInsets.symmetric(
                  vertical: 14.h,
                  horizontal: 30.w,
                ),
                buttonBackgroundColor: Colors.white.withOpacity(0.15),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.reservationScreen,
                  );
                },
              ),
            ),
          },
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
