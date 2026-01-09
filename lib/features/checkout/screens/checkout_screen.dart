// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/app/custom_widgets/custom_appbar.dart';
import 'package:restaurantapp/app/custom_widgets/custom_textfield.dart';
import 'package:restaurantapp/app/custom_widgets/delivery_widget.dart';
import 'package:restaurantapp/app/custom_widgets/primary_button.dart';
import 'package:restaurantapp/app/custom_widgets/screen_padding.dart';
import 'package:restaurantapp/app/dialogs/custom_info_dialog.dart';
import 'package:restaurantapp/app/dialogs/loading_dialog.dart';
import 'package:restaurantapp/app/functions/input_validators.dart';
import 'package:restaurantapp/app/functions/navigation_functions.dart';
import 'package:restaurantapp/app/functions/show_toast.dart';
import 'package:restaurantapp/app/routes/app_routes.dart';
import 'package:restaurantapp/core/network/client/base_client.dart';
import 'package:restaurantapp/core/network/client/get_response_data.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:restaurantapp/features/app_status/cubit/app_status_cubit.dart';
import 'package:restaurantapp/features/authentication/bloc/auth_bloc.dart';
import 'package:restaurantapp/features/cart/bloc/cart_bloc.dart';
import 'package:restaurantapp/features/cart/cubit/item_state_cubit.dart';
import 'package:restaurantapp/features/cart/screens/cart_screen.dart';
import 'package:restaurantapp/features/checkout/cubit/postal_code_handler_cubit.dart';
import 'package:restaurantapp/features/checkout/discount_cubit/discount_cubit.dart';
import 'package:restaurantapp/features/checkout/models/last_order_details_model.dart';
import 'package:restaurantapp/features/checkout/repo/checkout_repo.dart';
import 'package:restaurantapp/features/checkout/screens/complete_order_screen.dart';
import 'package:restaurantapp/features/checkout/widgets/date_picker_widget.dart';
import 'package:restaurantapp/features/order_day/cubit/order_day_cubit.dart';
import 'package:restaurantapp/features/settings/cubit/settings_cubit.dart';
import 'package:restaurantapp/main.dart';

class CheckoutViewModel {
  String address;
  String postalCode;
  String deliveryCharge;

  CheckoutViewModel({
    required this.address,
    required this.postalCode,
    required this.deliveryCharge,
  });

  CheckoutViewModel copyWith({
    String? address,
    String? postalCode,
    String? charge,
  }) {
    return CheckoutViewModel(
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
      deliveryCharge: charge ?? deliveryCharge,
    );
  }
}

num getSubTotal({
  required num total,
  required num discountOnDelivery,
  required num deliveryCharge,
}) {
  return locator<CurrentServiceTypeCubit>().state == ServiceType.delivery
      ? num.parse(
          ((deliveryCharge + total - (((discountOnDelivery) / 100) * total)))
              .toStringAsFixed(2))
      : num.parse(((total - (((discountOnDelivery) / 100) * total)))
          .toStringAsFixed(2));
}

class CheckoutScreen extends StatefulWidget {
  final CheckoutViewModel? checkoutItems;

  const CheckoutScreen({
    super.key,
    required this.checkoutItems,
  });

  @override
  State<CheckoutScreen> createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _deliveryDateController = TextEditingController();
  final TextEditingController _deliveryTimeController = TextEditingController();
  final TextEditingController _paymentMethodController =
      TextEditingController();
  final TextEditingController _noteForRestroController =
      TextEditingController();
  String selectedDateValue = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> datesAvailable = [];

  _fetchLastOrderDetails() async {
    final response = await locator<BaseClient>().getRequest(
      path: "/last-order-details",
    );
    final parsedResponse = await getParsedData(
      response,
      LastOrderDetailsModel.fromJson,
    );
    parsedResponse.fold(
      (l) {
        if (l.firstName != null) {
          _firstNameController.text = l.firstName;
        }
        if (l.lastName != null) {
          _lastNameController.text = l.lastName;
        }
        if (l.phone != null) {
          _phoneNumberController.text = l.phone;
        }
      },
      (r) {},
    );
  }

  _fetchDates(String date) async {
    showLoadingDialog();
    setState(() {
      datesAvailable = [];
    });
    final response = await locator<CheckoutRepo>().fetchDeliveryTimes(date);
    setState(() {
      datesAvailable = response;
    });
    hideLoadingDialog();
  }

  @override
  void initState() {
    locator<OrderDayCubit>().fetchOrderDays();
    final authState = locator<AuthBloc>().state;
    if (authState is UserLoggedInState) {
      _firstNameController.text = authState.signupResponse.user?.name ?? "";
    }
    if (mounted) {
      _fetchLastOrderDetails();
    }
    // locator<DiscountCubit>().fetchDiscount();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _deliveryDateController.dispose();
    _deliveryTimeController.dispose();
    _noteForRestroController.dispose();
    _paymentMethodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Checkout",
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingState) {
          return Form(
            key: _formKey,
            child: ScreenPadding(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    10.verticalSpace,
                    CustomTextField(
                      controller: _firstNameController,
                      labelText: "eg. Lionel",
                      hintText: "First Name",
                      validator: InputValidators.requiredValidator,
                    ),
                    10.verticalSpace,
                    CustomTextField(
                      controller: _lastNameController,
                      labelText: "e.g. Ritchie",
                      hintText: "Last Name",
                      validator: InputValidators.requiredValidator,
                    ),
                    10.verticalSpace,
                    CustomTextField(
                      controller: _phoneNumberController,
                      labelText: "e.g. +9779844464920",
                      hintText: "Phone Number",
                      isNumberInput: true,
                      maxLength: 12,
                      validator: InputValidators.requiredValidator,
                    ),
                    10.verticalSpace,
                    BlocBuilder<CurrentServiceTypeCubit, ServiceType>(
                      builder: (context, state) {
                        if (state == ServiceType.delivery) {
                          return Column(
                            children: [
                              DeliveryMiddlewareWidget(
                                child: CustomTextField(
                                  controller: TextEditingController(
                                    text: widget.checkoutItems?.postalCode,
                                  ),
                                  readOnly: true,
                                  hintText: "Post Code",
                                  labelText: widget.checkoutItems?.postalCode,
                                ),
                              ),
                              DeliveryMiddlewareWidget(
                                child: 10.verticalSpace,
                              ),
                              DeliveryMiddlewareWidget(
                                child: CustomTextField(
                                  controller: TextEditingController(
                                    text: widget.checkoutItems?.address,
                                  ),
                                  readOnly: true,
                                  hintText: "Address",
                                ),
                              ),
                              DeliveryMiddlewareWidget(
                                child: 10.verticalSpace,
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    BlocBuilder<CurrentServiceTypeCubit, ServiceType>(
                      builder: (context, state) {
                        return CustomTextField(
                          controller: _deliveryDateController,
                          hintText: state == ServiceType.collection
                              ? "Collection Date"
                              : "Home Delivery Date",
                          validator: InputValidators.requiredValidator,
                          readOnly: true,
                          suffixIcon: const Icon(
                            Icons.date_range,
                          ),
                          labelText: "Please select a date",
                          onTap: () async {
                            final Map<String, dynamic>? selectedDate =
                                await showDialog(
                              context: context,
                              builder: (context) {
                                return const Dialog(
                                  child: DatePickerWidget(),
                                );
                              },
                            );
                            if (selectedDate != null) {
                              if (selectedDate['key']
                                  .toLowerCase()
                                  .contains("closed")) {
                                showInfoDialog(
                                    message:
                                        "You cannot order for this day as the restaurant is closed on this day");
                              } else {
                                setState(() {
                                  selectedDateValue = selectedDate['value'];
                                  _deliveryDateController.text =
                                      selectedDate['key'];
                                });
                              }
                            }
                          },
                        );
                      },
                    ),
                    10.verticalSpace,
                    BlocBuilder<CurrentServiceTypeCubit, ServiceType>(
                      builder: (context, state) {
                        return CustomTextField(
                          controller: _deliveryTimeController,
                          validator: InputValidators.requiredValidator,
                          hintText: state == ServiceType.collection
                              ? "Collection Time"
                              : "Home Delivery Time",
                          labelText: "Please select a time",
                          readOnly: true,
                          suffixIcon: const Icon(
                            Icons.punch_clock,
                          ),
                          onTap: () async {
                            if (_deliveryDateController.text.isEmpty) {
                              showToast("Please select a date first.");
                              return;
                            } else {
                              await _fetchDates(selectedDateValue);
                              if (datesAvailable.isNotEmpty) {
                                String? selectedTime =
                                    await showModalBottomSheet(
                                        context: navigatorKey.currentContext!,
                                        builder: (context) {
                                          return ScreenPadding(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                20.verticalSpace,
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.w),
                                                  child: Text(
                                                    "Please select a time",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
                                                  ),
                                                ),
                                                10.verticalSpace,
                                                Expanded(
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        datesAvailable.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ListTile(
                                                        onTap: () {
                                                          Navigator.pop(
                                                            context,
                                                            datesAvailable[
                                                                index],
                                                          );
                                                        },
                                                        title: Text(
                                                          datesAvailable[index],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                if (selectedTime != null) {
                                  _deliveryTimeController.text = selectedTime;
                                }
                              }
                            }
                          },
                        );
                      },
                    ),
                    // DeliveryMiddlewareWidget(
                    //   child: 10.verticalSpace,
                    // ),
                    10.verticalSpace,
                    CustomTextField(
                      controller: _paymentMethodController,
                      validator: InputValidators.requiredValidator,
                      hintText: "Payment method",
                      labelText: "Select payment method",
                      readOnly: true,
                      suffixIcon: const Icon(
                        Icons.payments,
                      ),
                      onTap: () async {
                        String? paymentMethod = await showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              List<String> paymentOptions = ["Cash"];

                              // int cardStatus = locator<CardStatusCubit>().state;
                              final state =
                                  context.read<AppStatusCubit>().state;
                              // if (state is AppRunningState &&
                              //     state.appStatus.paymentStripe == "1") {
                              //   paymentOptions.add("Card");
                              // }
                              if (kDebugMode) {
                                paymentOptions.add("Card");
                              } else if (state is AppRunningState &&
                                  state.appStatus.paymentStripe == "1") {
                                paymentOptions.add("Card");
                              }
                              return ScreenPadding(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    15.verticalSpace,
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 10.w,
                                      ),
                                      child: Text(
                                        "Select Payment method",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ),
                                    ...paymentOptions
                                        .map((e) => ListTile(
                                              title: Text(e),
                                              onTap: () {
                                                Navigator.of(context).pop(e);
                                              },
                                            ))
                                        .toList(),
                                    10.verticalSpace
                                  ],
                                ),
                              );
                            });
                        if (paymentMethod != null) {
                          _paymentMethodController.text = paymentMethod;
                        }
                      },
                    ),
                    10.verticalSpace,
                    CustomTextField(
                      controller: _noteForRestroController,
                      hintText: "Note for restaurant",
                      labelText: "Note for restaurant",
                    ),
                    10.verticalSpace,
                    const Divider(),
                    10.verticalSpace,
                    BlocBuilder<PostalCodeHandlerCubit, CheckoutViewModel?>(
                      builder: (context, postalCode) {
                        return PrimaryButton(
                          buttonTitle: "Place Order",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              final cartState = locator<CartBloc>().state;
                              final ServiceType serviceType =
                                  locator<CurrentServiceTypeCubit>().state;
                              num cartTotal = getTotalPrice(cartState);
                              num subTotal = getSubTotal(
                                total: cartTotal,
                                discountOnDelivery: locator<DiscountCubit>()
                                        .state
                                        .discountOnDelivery ??
                                    0,
                                deliveryCharge:
                                    postalCode?.deliveryCharge != null
                                        ? num.parse(postalCode!.deliveryCharge)
                                        : 0,
                              );

                              Map<String, dynamic> body = {
                                "user": {
                                  "first_name": _firstNameController.text,
                                  "last_name": _lastNameController.text,
                                  "phone": _phoneNumberController.text,
                                  "address":
                                      widget.checkoutItems?.address ?? "",
                                  "order_date": selectedDateValue,
                                  "order_time": _deliveryTimeController.text,
                                  "payment_method": _paymentMethodController
                                              .text
                                              .toLowerCase() ==
                                          "card"
                                      ? "pay_by_card"
                                      : "cash_on_delivery",
                                },
                                "carts": cartState
                                    .map(
                                      (e) => {
                                        "id": e.item.itemId,
                                        "category_id": e.item.categoryId,
                                        "title": e.item.title,
                                        "rate": e.item.rate == "null"
                                            ? e.item.price
                                            : e.item.rate,
                                        "qty": e.totalItemCount,
                                        "vat_type": 1,
                                        "price": e.item.rate == "null"
                                            ? e.totalItemCount *
                                                (num.tryParse(e.item.price) ??
                                                    0)
                                            : e.totalItemCount *
                                                (num.tryParse(e.item.rate) ??
                                                    0),
                                      },
                                    )
                                    .toList(),
                                "carts_sub_total": subTotal,
                                "topping_total": 0,
                                // "miles": "1",
                                "carts_total": cartTotal,
                                "order_type":
                                    serviceType == ServiceType.collection
                                        ? "collection"
                                        : "home_delivery",
                                "delivery_charge":
                                    serviceType == ServiceType.collection
                                        ? 0
                                        : widget.checkoutItems?.deliveryCharge,
                                "postal_code":
                                    widget.checkoutItems?.postalCode ?? "",
                                "note_for_restaurant":
                                    _noteForRestroController.text,
                                "stripe_token": {
                                  "isTrusted": true,
                                },
                                "trustpay_token": {
                                  "isTrusted": true,
                                }
                              };
                              bool isCollection =
                                  locator<CurrentServiceTypeCubit>().state ==
                                      ServiceType.collection;
                              pushNamed(
                                context: context,
                                routeName: AppRoutes.completeOrderScreen,
                                arguments: CompleteOrderScreenViewModel(
                                  body: body,
                                  userDetails: {
                                    "Name":
                                        "${_firstNameController.text} ${_lastNameController.text}",
                                    "Phone": _phoneNumberController.text,
                                    "Order Type": isCollection
                                        ? "Collection"
                                        : "Delivery",
                                    if (locator<CurrentServiceTypeCubit>()
                                            .state ==
                                        ServiceType.delivery) ...{
                                      "Address":
                                          widget.checkoutItems?.address ?? "",
                                      "Post Code":
                                          widget.checkoutItems?.postalCode ??
                                              "",
                                      if (isCollection) ...{
                                        "Collection Date & Time":
                                            "$selectedDateValue -  ${_deliveryTimeController.text}"
                                      } else ...{
                                        "Delivery Date & Time":
                                            "$selectedDateValue -  ${_deliveryTimeController.text}"
                                      }
                                    },
                                    "Payment Method":
                                        _paymentMethodController.text,
                                    "Note for restaurant":
                                        _noteForRestroController.text,
                                  },
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                    30.verticalSpace
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
