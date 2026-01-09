import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/app/custom_widgets/custom_textfield.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/functions/input_validators.dart';
import 'package:restaurantapp/app/functions/show_toast.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/constants/app_colors.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/table_reservation/models/add_reservation_model.dart';
import 'package:restaurantapp/features/table_reservation/models/reservation_success_model.dart';
import 'package:restaurantapp/features/table_reservation/repo/table_reservation_repo.dart';

class TableReservationScreen extends StatefulWidget {
  const TableReservationScreen({super.key});

  @override
  State<TableReservationScreen> createState() => _TableReservationScreenState();
}

class _TableReservationScreenState extends State<TableReservationScreen> {
  final TextEditingController _noOfPeopleController = TextEditingController(
    text: noOfPeople[1].toString(),
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _captchaController = TextEditingController();

  static List<int> noOfPeople = [
    1,
    2,
    3,
    4,
    5,
    6,
  ];

  List<String> orderTimes = [];

  _fetchOrderTimes(String selectedDate) async {
    final response = await locator<TableReservationRepo>()
        .fetchTimeSlotsForDate(selectedDate);
    response.fold(
      (l) {
        setState(() {
          orderTimes = l;
        });
      },
      (r) => {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Reservation",
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ScreenPadding(
                child: CustomTextField(
                  controller: _nameController,
                  hintText: "Your Name",
                  validator: InputValidators.requiredValidator,
                  labelText: "Enter your name",
                ),
              ),
              10.verticalSpace,
              ScreenPadding(
                child: CustomTextField(
                  controller: _emailController,
                  hintText: "Email",
                  labelText: "Enter your email",
                  validator: InputValidators.emailValidator,
                ),
              ),
              10.verticalSpace,
              ScreenPadding(
                child: CustomTextField(
                  controller: _phoneController,
                  hintText: "Phone number",
                  isNumberInput: true,
                  maxLength: 10,
                  validator: InputValidators.requiredValidator,
                  labelText: "Enter your phone number",
                ),
              ),
              10.verticalSpace,
              ScreenPadding(
                child: CustomTextField(
                  controller: _dateController,
                  hintText: "Date",
                  validator: InputValidators.requiredValidator,
                  labelText: "Select date",
                  readOnly: true,
                  suffixIcon: const Icon(
                    Icons.date_range,
                  ),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      barrierColor: Colors.grey.withOpacity(0.5),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(
                          days: 100,
                        ),
                      ),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: AppColors.primaryColor,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      _dateController.text =
                          pickedDate.toString().split(" ").first;
                      String date =
                          "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
                      _fetchOrderTimes(date);
                    }
                  },
                ),
              ),
              10.verticalSpace,
              ScreenPadding(
                child: CustomTextField(
                  controller: _noOfPeopleController,
                  hintText: "Party Size",
                  validator: InputValidators.requiredValidator,
                  labelText: "Party Size",
                  readOnly: true,
                  suffixIcon: const Icon(
                    Icons.person,
                  ),
                  onTap: () async {
                    String? partySize = await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: noOfPeople.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).pop(
                                  noOfPeople[index].toString(),
                                );
                              },
                              title: Text(
                                noOfPeople[index].toString(),
                              ),
                            );
                          },
                        );
                      },
                    );
                    if (partySize != null) {
                      _noOfPeopleController.text = partySize;
                      // locator<TimeSlotCubit>().fetchTimeSlotAvailability(
                      //   _selectedDay.toString().split(" ").first,
                      //   partySize,
                      // );
                    }
                  },
                ),
              ),
              10.verticalSpace,
              ScreenPadding(
                child: CustomTextField(
                  controller: _timeController,
                  hintText: "Time",
                  labelText: "Tap to select time",
                  readOnly: true,
                  validator: InputValidators.requiredValidator,
                  suffixIcon: const Icon(
                    Icons.timer_sharp,
                  ),
                  onTap: () async {
                    String? selectedTime = await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: orderTimes.length,
                          itemBuilder: (context, index) {
                            String orderTime = orderTimes[index];

                            return ListTile(
                              onTap: () {
                                Navigator.of(context).pop(orderTime);
                              },
                              title: Text(
                                orderTime,
                              ),
                            );
                          },
                        );
                      },
                    );
                    if (selectedTime != null) {
                      _timeController.text = selectedTime;
                    }
                  },
                ),
              ),
              10.verticalSpace,
              ScreenPadding(
                child: CustomTextField(
                  controller: _messageController,
                  hintText: "Message",
                  // validator: InputValidators.requiredValidator,
                  labelText: "Enter message",
                ),
              ),
              10.verticalSpace,
              ScreenPadding(
                child: PrimaryButton(
                  buttonTitle: "Next",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final response =
                          await locator<TableReservationRepo>().reserveATable(
                        AddReservationModel(
                          captcha: _captchaController.text,
                          date: _dateController.text,
                          email: _emailController.text,
                          message: _messageController.text,
                          name: _nameController.text,
                          persons: _noOfPeopleController.text,
                          phone: _phoneController.text,
                          time: _timeController.text,
                        ),
                      );
                      response.fold(
                        (l) {
                          showToast(l.message.toString());
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.reservationSuccessScreen,
                            (route) => false,
                            arguments: ReservationSuccessModel(
                              booking: Booking(
                                partySize:
                                    int.parse(_noOfPeopleController.text),
                                customer: ReservationCustomer(
                                  fullName: _nameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  mobile: _phoneController.text,
                                ),
                                visitDate: _dateController.text,
                                visitTime: _timeController.text,
                              ),
                            ),
                          );
                        },
                        (r) => showErrorToast(
                          r.message!,
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
