import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/constants/app_colors.dart';

class FoodAllergyWidget extends StatelessWidget {
  const FoodAllergyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          // vertical: 0.w,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFfbeb4c),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Do you have food allergy ?",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            TextButton(
              onPressed: () {
                pushNamed(
                  context: context,
                  routeName: AppRoutes.contactUsScreen,
                );
              },
              child: Text(
                "Contact us",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ));
  }
}
