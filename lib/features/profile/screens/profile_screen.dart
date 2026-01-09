import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/app/functions/get_background_decoration.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/features/authentication/bloc/auth_bloc.dart';
import 'package:restaurantapp/features/profile/widgets/profile_logged_in_widget.dart';
import 'package:restaurantapp/features/profile/widgets/profile_not_logged_in_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Profile",
      ),
      body: Container(
        decoration: getBackgroundDecoration(),
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          bool isLoggedIn = state is UserLoggedInState;
          return Column(
            children: [
              if (isLoggedIn) ...{
                const ProfileLoggedInWidget(),
              } else
                const ProfileNotLoggedInWidget(),
              SizedBox(
                height: 10.h,
              ),
              if (isLoggedIn) ...{
                ListTile(
                  onTap: () {
                    pushNamed(
                      context: context,
                      routeName: AppRoutes.userHistoryScreen,
                    );
                  },
                  leading: const Icon(
                    Icons.history,
                  ),
                  title: const Text(
                    "My History",
                  ),
                ),
                ListTile(
                  onTap: () {
                    pushNamed(
                      context: context,
                      routeName: AppRoutes.changePasswordScreen,
                    );
                  },
                  leading: const Icon(
                    Icons.password_rounded,
                  ),
                  title: const Text(
                    "Change password",
                  ),
                ),
              },
              if (Platform.isIOS && isLoggedIn)
                ListTile(
                  onTap: () {
                    launchUrl(Uri.parse("https://forms.gle/w3xMW4uKechXjJKP6"));
                  },
                  leading: const Icon(
                    Icons.delete,
                  ),
                  title: const Text(
                    "Delete Account",
                  ),
                ),
              ListTile(
                onTap: () {
                  pushNamed(
                    context: context,
                    routeName: AppRoutes.restaurantInfoScreen,
                  );
                },
                leading: const Icon(
                  FontAwesomeIcons.info,
                ),
                title: const Text(
                  "Restaurant Info",
                ),
              ),
              ListTile(
                onTap: () {
                  pushNamed(
                    context: context,
                    routeName: AppRoutes.contactUsScreen,
                  );
                },
                leading: const Icon(
                  FontAwesomeIcons.info,
                ),
                title: const Text(
                  "Contact us",
                ),
              ),

              // ListTile(
              //   onTap: () {
              //     pushNamed(
              //       context: context,
              //       routeName: AppRoutes.aboutScreen,
              //     );
              //   },
              //   leading: const Icon(
              //     Icons.info,
              //   ),
              //   title: const Text(
              //     "About us",
              //   ),
              // ),
            ],
          );
        }),
      ),
    );
  }
}
