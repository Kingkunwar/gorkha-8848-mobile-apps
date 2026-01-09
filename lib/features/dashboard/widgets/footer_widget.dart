import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/ease_in_widget.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/constants/restaurant_constants.dart';

class FooterWidget extends StatelessWidget {
  final bool isBlacked;
  FooterWidget({
    super.key,
    this.isBlacked = true,
  });

  final List<Map<String, dynamic>> footerOptions = [
    {
      "Terms & Conditions": RestaurantConstants.termsAndConditionsUrl,
    },
    {
      "Privacy Policy": RestaurantConstants.privacyPolicyUrl,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Decorative divider with restaurant styling
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40.w),
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                isBlacked
                    ? Colors.grey.withOpacity(0.5)
                    : Colors.white.withOpacity(0.3),
                Colors.transparent,
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h),
        ScreenPadding(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: footerOptions
                .map(
                  (e) => EaseInWidget(
                    onTap: () {
                      if (e.values.first.startsWith("http")) {
                        pushNamed(
                          context: context,
                          routeName: AppRoutes.webViewScreen,
                          arguments: e.values.first,
                        );
                      } else {
                        pushNamed(
                          context: context,
                          routeName: e.values.first,
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isBlacked
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.3)
                                : Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Text(
                        e.keys.first,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: isBlacked
                                  ? null
                                  : Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
