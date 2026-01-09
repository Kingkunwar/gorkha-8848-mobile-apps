import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/features/profile/widgets/profile_container_widget.dart';

class ProfileNotLoggedInWidget extends StatelessWidget {
  const ProfileNotLoggedInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenPadding(
      child: Row(
        children: [
          const ProfileContainerWidget(),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: Center(
              child: PrimaryButton(
                buttonTitle: 'Login',
                onTap: () {
                  pushNamed(
                    context: context,
                    routeName: AppRoutes.loginScreen,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
        ],
      ),
    );
  }
}
