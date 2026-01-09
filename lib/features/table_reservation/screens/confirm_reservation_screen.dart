import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/dialogs/custom_confirmation_dialog.dart';
import 'package:restaurantapp/app/functions/extensions.dart';
import 'package:restaurantapp/app/functions/show_toast.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/table_reservation/models/reservation_model.dart';
import 'package:restaurantapp/features/table_reservation/repo/table_reservation_repo.dart';
import 'package:restaurantapp/features/table_reservation/widgets/check_box_widget.dart';
import 'package:restaurantapp/features/table_reservation/widgets/information_widget.dart';

class ConfirmReservationScreen extends StatefulWidget {
  final ReservationModel reservation;

  const ConfirmReservationScreen({
    super.key,
    required this.reservation,
  });

  @override
  State<ConfirmReservationScreen> createState() =>
      _ConfirmReservationScreenState();
}

class _ConfirmReservationScreenState extends State<ConfirmReservationScreen> {
  bool _isPrivacyPolicyAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Reservation",
      ),
      body: ScreenPadding(
        child: Column(
          children: [
            Text(
              "Confirm your details below",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            10.verticalSpace,
            const Divider(),
            InformationWidget(
              keyText: "Date",
              valueText: DateTime.parse(widget.reservation.visitDate!)
                  .toReadableFormat(),
            ),
            const Divider(),
            InformationWidget(
              keyText: "Time",
              valueText: widget.reservation.visitTime ?? "",
            ),
            const Divider(),
            InformationWidget(
              keyText: "People",
              valueText: widget.reservation.partySize.toString(),
            ),
            const Divider(),
            InformationWidget(
              keyText: "First Name",
              valueText: widget.reservation.customer?.firstName ?? "",
            ),
            const Divider(),
            InformationWidget(
              keyText: "Last Name",
              valueText: widget.reservation.customer?.surname ?? "",
            ),
            const Divider(),
            InformationWidget(
              keyText: "Mobile Number",
              valueText: widget.reservation.customer?.mobile ?? "",
            ),
            const Divider(),
            InformationWidget(
              keyText: "Email Address",
              valueText: widget.reservation.customer?.email ?? "",
            ),
            const Spacer(),
            CheckBoxWidget(
              value: _isPrivacyPolicyAccepted,
              title: "I have read and accept the Privacy & Policy",
              onChanged: (val) {
                setState(() {
                  _isPrivacyPolicyAccepted = !_isPrivacyPolicyAccepted;
                });
              },
            ),
            10.verticalSpace,
            PrimaryButton(
              buttonTitle: "Complete Booking",
              onTap: () async {
                if (_isPrivacyPolicyAccepted) {
                  final bool confirmation = await getConfirmationDialog(
                    title: "Do you want to complete the booking ?",
                  );
                  if (confirmation) {
                    final response =
                        await locator<TableReservationRepo>().reserveTable(
                      widget.reservation,
                    );
                    response.fold(
                      (l) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.reservationSuccessScreen,
                          (route) => false,
                          arguments: widget.reservation,
                        );
                      },
                      (r) => showErrorToast(
                        r.message!,
                      ),
                    );
                  }
                } else {
                  showErrorToast(
                    "You need to accept the privacy & Policy.",
                  );
                }
              },
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
