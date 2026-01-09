import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/ease_in_widget.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/functions/show_toast.dart';
import 'package:restaurantapp/app/functions/url_launcher_functions.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/constants/restaurant_constants.dart';

class FcpAppbarWidget extends StatelessWidget {
  final bool showBackArrow;
  final bool showCart;
  const FcpAppbarWidget({
    super.key,
    this.showBackArrow = true,
    this.showCart = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: const BoxDecoration(color: Colors.black54),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 25.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EaseInWidget(
                onTap: () {
                  // Navigator.of(context).pushNamedAndRemoveUntil(
                  //   AppRoutes.newDashboardScreen,
                  //   (route) => false,
                  // );
                },
                child: Text(
                  "Gorkha 8848",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(color: Colors.white),
                ),
                // child: Image.asset(
                //   AssetSource.logo,
                //   color: Colors.white,
                //   height: 30.h,
                // ),
              ),
              if (showCart) ...{
                const Spacer(),
                // const CustomCartWidget(
                //   cartColor: Colors.white,
                // ),
                SizedBox(width: 10.w),
                EaseInWidget(
                  onTap: () {
                    pushNamed(
                      context: context,
                      routeName: AppRoutes.profileScreen,
                    );
                  },
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 10.w),
              },
            ],
          ),
          10.h.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.phone, color: Colors.white),
              SizedBox(width: 2.w),
              EaseInWidget(
                onTap: () {
                  launchPhone(RestaurantConstants.phoneNumber);
                },
                child: Text(
                  RestaurantConstants.phoneNumber,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.email, color: Colors.white),
              SizedBox(width: 2.w),
              EaseInWidget(
                onLongPress: () async {
                  await Clipboard.setData(
                    ClipboardData(text: RestaurantConstants.email),
                  );
                  showToast("Email copied to clipboard.");
                },
                onTap: () {
                  launchEmail(RestaurantConstants.email);
                },
                child: Text(
                  RestaurantConstants.email.replaceAll("nmaidstone.com", "..."),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
