import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/ease_in_widget.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/dialogs/custom_confirmation_dialog.dart';
import 'package:restaurantapp/app/functions/logout.dart';
import 'package:restaurantapp/features/authentication/bloc/auth_bloc.dart';
import 'package:restaurantapp/features/authentication/models/signup_response_model.dart';
import 'package:restaurantapp/features/profile/widgets/profile_container_widget.dart';

class ProfileLoggedInWidget extends StatelessWidget {
  const ProfileLoggedInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UserLoggedInState) {
          UserModel? user = state.signupResponse.user;
          return ScreenPadding(
            child: Row(
              children: [
                const ProfileContainerWidget(),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? "",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        user?.email ?? "",
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
                EaseInWidget(
                  onTap: () async {
                    bool confirmation = await getConfirmationDialog(
                      title: "Do you want to logout ?",
                    );
                    if (confirmation) {
                      logout();
                    }
                  },
                  child: const Icon(
                    Icons.logout,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                )
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
