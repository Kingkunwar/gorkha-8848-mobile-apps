import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/get_background_decoration.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/constants/app_colors.dart';
import 'package:restaurantapp/features/table_reservation/models/reservation_success_model.dart';

class ReservationSuccessScreen extends StatefulWidget {
  final ReservationSuccessModel reservation;
  const ReservationSuccessScreen({
    super.key,
    required this.reservation,
  });

  @override
  State<ReservationSuccessScreen> createState() =>
      _ReservationSuccessScreenState();
}

class _ReservationSuccessScreenState extends State<ReservationSuccessScreen> {
  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';
    try {
      // Assuming date format is "MM/dd/yyyy" or similar
      final parts = dateString.split('/');
      if (parts.length == 3) {
        final date = DateTime(
          int.parse(parts[2]),
          int.parse(parts[0]),
          int.parse(parts[1]),
        );
        return DateFormat('MMMM d, yyyy').format(date);
      }
      return dateString;
    } catch (e) {
      return dateString;
    }
  }

  String _formatTime(String? timeString) {
    if (timeString == null || timeString.isEmpty) return 'N/A';
    try {
      // Try to parse and format time if needed
      return timeString;
    } catch (e) {
      return timeString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final reservation = widget.reservation;
    final customerName = reservation.booking?.customer != null
        ? '${reservation.booking?.customer?.fullName ?? ''} ${reservation.booking?.customer?.surname ?? ''}'
            .trim()
        : 'Guest';

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
          title: "Reservation Confirmed",
        ),
        body: Container(
          decoration: getBackgroundDecoration(),
          child: ScreenPadding(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  // Success Animation
                  Container(
                    width: 150.w,
                    height: 150.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Lottie.asset(
                        'assets/check.json',
                        width: 120.w,
                        height: 120.w,
                      ),
                    ),
                  ),
                  30.verticalSpace,
                  // Success Title
                  Text(
                    "Reservation Successful!",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  10.verticalSpace,
                  Text(
                    "Your table reservation has been confirmed",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                    textAlign: TextAlign.center,
                  ),
                  40.verticalSpace,
                  // Reservation Details Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.restaurant_menu,
                              color: AppColors.primaryColor,
                              size: 24.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Reservation Details",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor,
                                  ),
                            ),
                          ],
                        ),
                        24.verticalSpace,
                        _buildDetailRow(
                          context,
                          Icons.person,
                          "Guest Name",
                          customerName.isEmpty ? 'Guest' : customerName,
                        ),
                        16.verticalSpace,
                        _buildDetailRow(
                          context,
                          Icons.calendar_today,
                          "Date",
                          _formatDate(reservation.booking?.visitDate),
                        ),
                        16.verticalSpace,
                        _buildDetailRow(
                          context,
                          Icons.access_time,
                          "Time",
                          _formatTime(reservation.booking?.visitTime),
                        ),
                        16.verticalSpace,
                        _buildDetailRow(
                          context,
                          Icons.group,
                          "Party Size",
                          reservation.booking?.partySize != null
                              ? "${reservation.booking?.partySize} ${reservation.booking?.partySize == 1 ? 'person' : 'people'}"
                              : 'N/A',
                        ),
                        if (reservation.booking?.specialRequests != null &&
                            reservation
                                .booking!.specialRequests!.isNotEmpty) ...[
                          16.verticalSpace,
                          _buildDetailRow(
                            context,
                            Icons.note,
                            "Special Requests",
                            reservation.booking?.specialRequests ?? '',
                            isMultiLine: true,
                          ),
                        ],
                      ],
                    ),
                  ),
                  30.verticalSpace,
                  // Information Message Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.primaryColor,
                          size: 24.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            "An information email with your reservation details will be sent to your email address. Please check your inbox and junk folder.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.textColor,
                                  height: 1.5,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  40.verticalSpace,
                  PrimaryButton(
                    buttonTitle: "Back to Home",
                    onTap: () {
                      pushAndRemoveUntil(
                        routeName: AppRoutes.newDashboardScreen,
                      );
                    },
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    bool isMultiLine = false,
  }) {
    return Row(
      crossAxisAlignment:
          isMultiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
          size: 20.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      fontSize: 12.sp,
                    ),
              ),
              4.verticalSpace,
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
