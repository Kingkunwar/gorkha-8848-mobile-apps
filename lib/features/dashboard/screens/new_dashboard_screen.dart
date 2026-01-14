import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/fcp_appbar.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/constants/asset_source.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/app_status/cubit/app_status_cubit.dart';
import 'package:restaurantapp/features/dashboard/widgets/footer_widget.dart';
import 'package:restaurantapp/features/dashboard/widgets/intro_widget.dart';
import 'package:restaurantapp/features/in_app_update/app_updater.dart';
import 'package:restaurantapp/features/order_day/cubit/order_day_cubit.dart';
import 'package:restaurantapp/features/settings/cubit/settings_cubit.dart';
import 'package:upgrader/upgrader.dart';

class NewDashboardScreen extends StatefulWidget {
  const NewDashboardScreen({super.key});

  @override
  State<NewDashboardScreen> createState() => _NewDashboardScreenState();
}

class _NewDashboardScreenState extends State<NewDashboardScreen> {
  @override
  void initState() {
    super.initState();
    locator<SettingsCubit>().fetchSettings();
    locator<OrderDayCubit>().fetchOrderDays();
    locator<AppStatusCubit>().checkAppStatus();
    if (Platform.isAndroid) {
      AppUpdater().checkForAndroidAppUpdate();
    }
  }

  Widget _body(AppStatusModel appStatus) {
    return Stack(
      children: [
        // Background with restaurant ambiance
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(
                AssetSource.dashboardBackground,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 3.0,
              sigmaY: 3.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.75),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Main content
        SafeArea(
          child: Column(
            children: [
              const FcpAppbarWidget(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      // Welcome section with restaurant styling
                      Builder(builder: (context) {
                        AppStatusModel status = appStatus;
                        return IntroWidget(
                          isCollectionEnabled: status.collectionEnabled == true,
                          isDeliveryEnabled: status.deliveryEnabled == true,
                          isTableReservationEnabled:
                              status.tableReservation.toString() == "1",
                        );
                      }),
                      SizedBox(height: 15.h),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.reviewScreen,
                          );
                        },
                        child: Text(
                          "Customer Reviews",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                  ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      FooterWidget(
                        isBlacked: false,
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _underMaintenanceWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/under_maintenance.png",
            width: 0.2.sw,
          ),
          30.verticalSpace,
          ScreenPadding(
            child: Text(
              message.length == 1
                  ? "The app is currently under maintenance mode. Please wait for some time."
                  : message,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppStatusCubit, AppStatusState>(
        builder: (context, state) {
          if (state is AppRunningState &&
              state.appStatus.isMobileApiDisabled.toString() == "0") {
            return Platform.isIOS
                ? UpgradeAlert(
                    upgrader: Upgrader(
                      durationUntilAlertAgain: const Duration(hours: 1),

                      // minAppVersion: shouldForceUpdateApp ? minAppVersionIos : null,
                    ),
                    child: _body(state.appStatus),
                  )
                : _body(state.appStatus);
          } else if (state is AppRunningState &&
              state.appStatus.isMobileApiDisabled.toString() == "1") {
            return _underMaintenanceWidget(
              state.appStatus.mobileApiDisabledMessage != null &&
                      state.appStatus.mobileApiDisabledMessage!.isNotEmpty
                  ? state.appStatus.mobileApiDisabledMessage!
                  : "App under maintenance. Please try again later.",
            );
          } else if (state is UnderMaintenanceState) {
            return _underMaintenanceWidget(state.message);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
